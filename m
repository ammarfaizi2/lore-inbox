Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318142AbSHLQCN>; Mon, 12 Aug 2002 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHLQCN>; Mon, 12 Aug 2002 12:02:13 -0400
Received: from mail.ccur.com ([208.248.32.212]:41232 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S318142AbSHLQCG>;
	Mon, 12 Aug 2002 12:02:06 -0400
Message-ID: <3D57DF3C.EEB24D50@ccur.com>
Date: Mon, 12 Aug 2002 12:15:56 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frankeh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Content-Type: multipart/mixed;
 boundary="------------92B1FEC378C524F00F69D49A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------92B1FEC378C524F00F69D49A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I was doing some similar work last week and stumbled on the
this discussion.  I have been working with the Posix timers
patch and was looking for a nice way to allocate ids for
timers.

I looked at get_pid() and also the code used for ipc/msg.c
and friends.  I thought I could do better so I wrote the
attached routines.  They are a subtle variation on the bitmap
theme.  I'm mixing a bitmap with a sparse array which is implemented
as a radix tree.  This means that the data structure
grows/shrinks as needed.  The interface is:

	id = id_new(idp, pointer);
	id_remove(idp, id);
	pointer = id_lookup(idp, id);

The idp is a pointer to the structure which defines the id space.
This provides, not only the bitmap allocation of the id but also, mapping
the id to a pointer.  In the case of pids, this would replace the
hash table used by find_task_by_pid().

So far I have been playing with this code in user space.  I'm including
my test harness.  I plan to try it with your program later today.
My program was written more to test correctness, but I do collect
a few numbers.  Here is the output:

jhouston@linux:~/id > time ./id_test
my_id.count=1
new_cnt=5002501
avr_depth = 4996
id_lookup took 101 cycles
id_new took 204 cycles
id_remove took 148 cycles 
real    0m3.476s

That's about 0.5us total to allocate an id, lookup a random id
and remove it with a table containing 5000 ids.  The times
only double for 500000 ids.

Jim Houston - Concurrent Computer Corporation.
--------------92B1FEC378C524F00F69D49A
Content-Type: text/plain; charset=us-ascii;
 name="id.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="id.c"

/*
 * Small id to pointer translation service.  
 *
 * It uses a radix tree like structure as a sparse array indexed 
 * by the id to obtain the pointer.  The bitmap makes allocating
 * an new id quick.  
 */

#include "id.h"

#ifdef __KERNEL__
static kmem_cache_t *id_layer_cache;
#endif

void *id_lookup(struct id *idp, int id)
{
	int n = idp->layers * ID_BITS;
	struct id_layer *p = idp->top;

	if (id >= (1 << n))
		return(NULL);

	while (n > 0 && p) {
		n -= ID_BITS;
		p = p->ary[(id >> n) & ID_MASK];
	}
	return((void *)p);
}

static int sub_alloc(struct id_layer *p, int shift, int id, void *ptr)
{
	int n = (id >> shift) & ID_MASK;
	int bitmap = p->bitmap;
	int id_base = id & ~((1 << (shift+ID_BITS))-1);
	int v;
	
	for ( ; n <= ID_MASK; n++, id = id_base + (n << shift)) {
		if (bitmap & (1 << n))
			continue;
		if (shift == 0) {
			p->ary[n] = (struct id_layer *)ptr;
			p->bitmap |= 1<<n;
			return(id);
		}
		if (!p->ary[n])
			p->ary[n] = alloc_layer();
		if (v = sub_alloc(p->ary[n], shift-ID_BITS, id, ptr)) {
			update_bitmap(p, n);
			return(v);
		}
	}
	return(0);
}

int id_new(struct id *idp, void *ptr)
{
	int n = idp->layers * ID_BITS;
	int last = idp->last;
	struct id_layer **p, *new;
	int id, v;
	
	/*
	 * Add a new layer if the array is full or the last id
	 * was at the limit and we don't want to wrap.
	 */
	if ((last == ((1 << n)-1) && last < idp->min_wrap) ||
		idp->count == (1 << n)) {
		++idp->layers;
		n += ID_BITS;
		new = alloc_layer();
		new->ary[0] = idp->top;
		idp->top = new;
		update_bitmap(new, 0);
	}
	if (last >= ((1 << n)-1))
		last = 0;

	/*
	 * Search for a free id starting after last id allocated.
	 * If that fails wrap back to start.
	 */
	id = last+1;
	if (!(v = sub_alloc(idp->top, n-ID_BITS, id, ptr)))
		v = sub_alloc(idp->top, n-ID_BITS, 1, ptr);
	idp->last = v;
	idp->count++;
	return(v);
}


static int sub_remove(struct id_layer *p, int shift, int id)
{
	int n = (id >> shift) & ID_MASK;
	int i, bitmap, rv;
	
if (!p) {
printf("in sub_remove for id=%d called with null pointer.\n", id);
return(0);
}
	rv = 0;
	bitmap = p->bitmap & ~(1<<n);
	p->bitmap = bitmap;
	if (shift == 0) {
		p->ary[n] = NULL;
		rv = !bitmap;
	} else {
		if (sub_remove(p->ary[n], shift-ID_BITS, id)) {
			free_layer(p->ary[n]);
			p->ary[n] = 0;
			for (i = 0; i < (1 << ID_BITS); i++)
				if (p->ary[i])
					break;
			if (i == (1 << ID_BITS))
				rv = 1;
		}
	}
	return(rv);
}

void id_remove(struct id *idp, int id)
{
	sub_remove(idp->top, (idp->layers-1)*ID_BITS, id);
	idp->count--;
}

void id_init(struct id *idp, int min_wrap)
{
#ifdef __KERNEL__
	id_layer_cache = kmem_cache_create("id_layer_cache", 
		sizeof(struct id_layer), 0, 0, 0, 0);
#endif
	idp->count = 1;
	idp->last = 0;
	idp->layers = 1;
	idp->top = alloc_layer();
	idp->top->bitmap = 1;
	idp->min_wrap = min_wrap;
}


--------------92B1FEC378C524F00F69D49A
Content-Type: text/plain; charset=us-ascii;
 name="id.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="id.h"

/*
 * Small id to pointer translation service avoiding fixed sized
 * tables.
 */

#define ID_BITS 5

#define ID_MASK ((1 << ID_BITS)-1)
#define ID_FULL ((1 << (1 << ID_BITS))-1)

struct id_layer {
	unsigned int	bitmap: (1<<ID_BITS);
	struct id_layer	*ary[1<<ID_BITS];
};

struct id {
	int		layers;
	int		last;
	int		count;
	int		min_wrap;
	struct id_layer *top;
};

void *id_lookup(struct id *idp, int id);
int id_new(struct id *idp, void *ptr);
void id_remove(struct id *idp, int id);
void id_init(struct id *idp, int min_wrap);

static inline update_bitmap(struct id_layer *p, int bit)
{
	if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)
		p->bitmap |= 1<<bit;
	else
		p->bitmap &= ~(1<<bit);
}

#ifndef __KERNEL__

#ifndef NULL
#define NULL 0
#endif

static inline struct id_layer *alloc_layer()
{
	struct id_layer *new;

	new = (struct id_layer *)malloc(sizeof(struct id_layer));
	bzero((void *)new, sizeof(struct id_layer));
	return(new);
	
}

static inline void free_layer(struct id_layer *p)
{
	free((void *)p);
}

#else

extern kmem_cache_t *id_layer_cache;

static inline struct id_layer *alloc_layer()
{
	return(kmem_cache_alloc(id_layer_cache, GFP_KERNEL));
}

static inline void free_layer(struct id_layer *p)
{
	kmem_cache_free(id_layer_cache, p);
}

#endif


--------------92B1FEC378C524F00F69D49A
Content-Type: text/plain; charset=us-ascii;
 name="id_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="id_test.c"

/*
 * Test program for id.c
 */

#include <stdlib.h>
#include "id.h"

struct id my_id;

main()
{
	int i, n;
	void *v;

	id_init(&my_id, 10000);
	
	random_test();
}

#define LIST_SZ 50000

struct id_list {
	int id;
	int ptr;
} id_list[LIST_SZ];

int list_cnt;
int new_cnt;
int max = 5000;
int count = 10000000;

long long avr_depth;

#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
  
static inline unsigned long get_tsc(void)
{
	register unsigned long eax, edx;

	rdtsc(eax,edx);
	return(eax);
}



random_test()
{
	int n, i;
	void *v;
	unsigned long t1, t2, t3, t4;

	for (n = 0; n < count; n++) {
		/*
		 * favor insertion so we will tend to run will max
		 * id's active.
		 */
		if (list_cnt && (list_cnt > max || rand() < (RAND_MAX/4))) {
			i = rand() % list_cnt;
			v = id_lookup(&my_id, id_list[i].id);
			if ((int)v != id_list[i].ptr) {
				printf("list_cnt=%d, i=%d\n", list_cnt, i);
				printf("failed id=%d, expected %d got %d\n",
					id_list[i].id, id_list[i].ptr, (int)v);
			} else {
#if 0
				printf("rm id=%d, ptr=%d\n",
					id_list[i].id, id_list[i].ptr);
#endif
				id_remove(&my_id, id_list[i].id);
			}
			id_list[i] = id_list[--list_cnt];
		} else {
			new_cnt++;
			id_list[list_cnt].id = id_new(&my_id, (void *)new_cnt);
			id_list[list_cnt].ptr = new_cnt;
#if 0
			printf("ins id=%d, ptr=%d\n",
				id_list[list_cnt].id, id_list[list_cnt].ptr);
#endif
			list_cnt++;
			avr_depth += list_cnt;
		}
	}
t1 = get_tsc();
id_lookup(&my_id, id_list[0].id);
t2 = get_tsc();
n = id_new(&my_id, (void *)++new_cnt);
t3 = get_tsc();
id_remove(&my_id, n);
t4 = get_tsc();

	for (i = 0; i < list_cnt; i++) {
		v = id_lookup(&my_id, id_list[i].id);
		if ((int)v != id_list[i].ptr) {
			printf("failed id=%d, expected %d got %d\n",
				id_list[i].id, id_list[i], (int)v);
		}
		id_remove(&my_id, id_list[i].id);
	}
	printf("my_id.count=%d\n", my_id.count);
	printf("new_cnt=%d\n", new_cnt);
	printf("avr_depth = %d\n", (int)(avr_depth/new_cnt));
	printf("id_lookup took %d cycles\n", t2-t1);
	printf("id_new took %d cycles\n", t3-t2);
	printf("id_remove took %d cycles\n", t4-t3);
}

--------------92B1FEC378C524F00F69D49A--

