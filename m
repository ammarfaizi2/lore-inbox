Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130480AbRCILLP>; Fri, 9 Mar 2001 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbRCILLG>; Fri, 9 Mar 2001 06:11:06 -0500
Received: from PO8.ANDREW.CMU.EDU ([128.2.10.108]:33691 "EHLO
	po8.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S130480AbRCILKu>; Fri, 9 Mar 2001 06:10:50 -0500
Message-ID: <kue=bLNz000142mEtL@andrew.cmu.edu>
Date: Fri,  9 Mar 2001 06:09:11 -0500 (EST)
From: James R Bruce <bruce+@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no>
In-Reply-To: <3AA88891.294C17A0@sasken.com>
	<3AA89624.46DBADD7@idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quicksort works just fine on a linked list, as long as you broaden
your view beyond the common array-based implementations.  See
"http://www.cs.cmu.edu/~jbruce/sort.cc" for an example, although I
would recommend using a radix sort for linked lists in most situations
(sorry for the C++, but it was handy...).

9-Mar-2001 Re: quicksort for linked list by Helge Hafting@idb.hist.n 
> Manoj Sontakke wrote:
> > 
> > Hi
> >         Sorry, these questions do not belog here but i could not find any
> > better place.
> > 
> > 1. Is quicksort on doubly linked list is implemented anywhere? I need it
> > for sk_buff queues.
>  
> I cannot see how the quicksort algorithm could work on a doubly
> linked list, as it relies on being able to look
> up elements directly as in an array.
>  
> You can probably find algorithms for sorting a linked list, but
> it won't be quicksort.

It's quicksort as long as you do pivot/split, the array gymnastics
that most implementations do to avoid updating array elements isn't
really critical to its operation.

> 1. find out how many elements there are.  (Count them if necessary)
> 2. Allocate a pointer array of this size.
> 3. fill the pointer array with pointers to list members.
> 4. quicksort the pointer array
> 5. Traverse the pointer array and set the links for each
>    list member to point to next/previous element pointed
>    to by the array.  Now you have a sorted linked list!

I think a radix sort like the following would work better with about
the same (or less) storage, provided you're comparing ints (this is
for a kernel modification after all, right?).  You just need to
determine the number of passes to cover all the bits in the numbers
you want to sort.

 - Jim Bruce


#define RADIX_BITS 6
#define RADIX      (1 << RADIX_BITS)
#define RADIX_MASK (RADIX - 1)

struct item *radix_sort(struct item *list,int passes)
// Sort list, largest first
{
  struct item *tbl[RADIX],*p,*pn;
  int slot,shift;
  int i,j;

  // Handle trivial cases
  if(!list || !list->next) return(list);

  // Initialize table
  for(j=0; j<RADIX; j++) tbl[j] = NULL;

  for(i=0; i<passes; i++){
    // split list into buckets
    shift = RADIX_BITS * i;
    p = list;

    while(p){
      pn = p->next;
      slot = ((p->key) >> shift) & RADIX_MASK;
      p->next = tbl[slot];
      tbl[slot] = p;
      p = pn;
    }

    // integrate back into partially ordered list
    list = NULL;
    for(j=0; j<RADIX; j++){
      p = tbl[j];
      tbl[j] = NULL;  // clear out table for next pass
      while(p){
        pn = p->next;
        p->next = list;
        list = p;
        p = pn;
      }
    }
  }

  // fix prev pointers in list
  list->prev = NULL;
  p = list;
  while(pn = p->next){
    pn->prev = p;
    p = pn;
  }

  return(list);
}

