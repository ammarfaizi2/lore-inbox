Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUH2Sm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUH2Sm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUH2SmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:42:10 -0400
Received: from holomorphy.com ([207.189.100.168]:22703 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268266AbUH2SlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:41:18 -0400
Date: Sun, 29 Aug 2004 11:41:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829184114.GS5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20040829162252.GG5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 29, 2004 at 09:22:52AM -0700, William Lee Irwin III wrote:
> Well, since I couldn't stop vomiting for hours after I looked at the
> code for readprofile(1), here's a reimplementation, with various
> misfeatures removed, included as a MIME attachment.

I guess I might as well write a diffprof(1) too.


-- wli

--tqI+Z3u+9OQ7kwn0
Content-Type: text/x-csrc; charset=us-ascii
Content-Description: diffprof.c
Content-Disposition: attachment; filename="diffprof.c"

/*
 * diffprof(1) implementation.
 * (C) 2004 William Irwin, Oracle
 * Licensed under GPL, and derived from the following GPL code:
 * linked list implementation (C) Linus Torvalds and various others
 * jhash implementation (C) Bob Jenkins, David S. Miller, and others
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <limits.h>

#define TABLE_SIZE		1024
#define offsetof(type, member)	((size_t)(unsigned long)(&((type *)0)->member))
#define list_entry(elem, type, member)					\
		((type *)((char *)(elem) - offsetof(type, member)))
#define list_for_each(elem, list, member)				\
	for (elem = list_entry((list)->next, typeof(*(elem)), member);	\
		&(elem)->member != (list);				\
		elem = list_entry((elem)->member.next, typeof(*(elem)), member))
#define list_for_each_safe(elem, save, list, member)			\
for (elem = list_entry((list)->next, typeof(*(elem)), member),		\
	save = list_entry((elem)->member.next, typeof(*(elem)), member);\
		&(elem)->member != (list);				\
	elem = save,							\
	save = list_entry((save)->member.next, typeof(*(elem)), member))

/*
 * A number close to ((sqrt(5) - 1)/2) * 2**32 with low d(n) (few divisors)
 * 0x9e3779b9 == 2654435769 == 3 * 89 * 523 * 19009
 */
#define JHASH_GOLDEN_RATIO      0x9e3779b9
#define __jhash_mix(a, b, c)						\
{									\
	a -= b; a -= c; a ^= (c) >> 13;					\
	b -= c; b -= a; b ^= (a) << 8;					\
	c -= a; c -= b; c ^= (b) >> 13;					\
	a -= b; a -= c; a ^= (c) >> 12;					\
	b -= c; b -= a; b ^= (a) << 16;					\
	c -= a; c -= b; c ^= (b) >> 5;					\
	a -= b; a -= c; a ^= (c) >> 3;					\
	b -= c; b -= a; b ^= (a) << 10;					\
	c -= a; c -= b; c ^= (b) >> 15;					\
}

struct list {
	struct list *next, *prev;
};

struct sym {
	long len, hits[2];
	char *s;
	struct list list;
};

static struct list table[TABLE_SIZE];

static uint32_t jhash(const void *key, uint32_t length, uint32_t initval)
{
	const uint8_t *k = key;
	uint32_t a = JHASH_GOLDEN_RATIO, b = JHASH_GOLDEN_RATIO, c = initval,
								len = length;

	while (len >= 12) {
		a += k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16)
						+ ((uint32_t)k[3] << 24);
		b += k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16)
						+ ((uint32_t)k[7] << 24);
		c += k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16)
						+ ((uint32_t)k[11] << 24);
		__jhash_mix(a,b,c);
		k += 12;
		len -= 12;
	}
	c += length;
	switch (len) {
		case 11:
			c += (uint32_t)k[10] << 24;
		case 10:
			c += (uint32_t)k[9] << 16;
		case 9:
			c += (uint32_t)k[8] << 8;
		case 8:
			b += (uint32_t)k[7] << 24;
		case 7:
			b += (uint32_t)k[6] << 16;
		case 6:
			b += (uint32_t)k[5] << 8;
		case 5:
			b += k[4];
		case 4:
			a += (uint32_t)k[3] << 24;
		case 3:
			a += (uint32_t)k[2] << 16;
		case 2:
			a += (uint32_t)k[1] << 8;
		case 1:
			a += k[0];
	}
	__jhash_mix(a,b,c);
	return c;
}

static void list_init(struct list *list)
{
	list->next = list->prev = list;
}

static void __list_add(struct list *prev, struct list *next, struct list *elem)
{
	next->prev = elem;
	elem->next = next;
	elem->prev = prev;
	prev->next = elem;
}

static void list_add(struct list *list, struct list *elem)
{
	__list_add(list, list->next, elem);
}

static void __list_del(struct list *prev, struct list *next)
{
	next->prev = prev;
	prev->next = next;
}

static void list_del(struct list *list)
{
	__list_del(list->prev, list->next);
}

static void table_init(void)
{
	int i;

	for (i = 0; i < TABLE_SIZE; ++i)
		list_init(&table[i]);
}

struct sym *sym_alloc(const char *buf, int after)
{
	struct sym *sym = malloc(sizeof(struct sym));

	if (sym) {
		memset(sym, 0, sizeof(struct sym));
		sym->s = strdup(buf);
		if (!sym->s)
			goto err_sym;
		if (sscanf(buf, "%ld %s\n", &sym->hits[after], sym->s) != 2)
			goto err_str;
		sym->len = strlen(sym->s);
	}
	return sym;
err_str:
	free(sym->s);
err_sym:
	free(sym);
	return NULL;
}

static void sym_free(struct sym *sym)
{
	free(sym->s);
	free(sym);
}

static void sym_emit(struct sym *sym)
{
	static int digits = 0;
	long difference = sym->hits[1] - sym->hits[0];

	if (!digits) {
		unsigned long n = ULONG_MAX;

		for (n = ULONG_MAX; n >= 10; n /= 10)
			++digits;
		digits += !!n;
	}
	if (difference)
		printf("%*ld %s\n", digits, difference, sym->s);
}

static void sym_hash(struct sym *sym, int after)
{
	struct sym *collide;
	struct list *list;

	list = &table[jhash(sym->s, sym->len, sym->len) % TABLE_SIZE];
	list_for_each(collide, list, list) {
		if (collide->len == sym->len && !strcmp(collide->s, sym->s)) {
			collide->hits[after] = sym->hits[after];
			sym_emit(collide);
			list_del(&collide->list);
			sym_free(collide);
			sym_free(sym);
			return;
		}
	}
	list_add(list, &sym->list);
}

static void sym_cleanup(void)
{
	struct sym *save, *sym;
	int i;

	for (i = 0; i < TABLE_SIZE; ++i) {
		list_for_each_safe(sym, save, &table[i], list) {
			list_del(&sym->list);
			sym_emit(sym);
			sym_free(sym);
		}
	}
}

static int __read_sym(FILE *file, char **buf, size_t *bufsz, int after)
{
	struct sym *sym;
	ssize_t ret = getline(buf, bufsz, file);

	if (ret <= 0)
		return ret;
	if (!(sym = sym_alloc(*buf, after)))
		return -1;
	sym_hash(sym, after);
	return 0;
}

static void read_syms(FILE *before, FILE *after)
{
	char *buf = NULL;
	size_t bufsz;
	int eof_before = 0, eof_after = 0;

	while (!eof_before && !eof_after) {
		if (!eof_before) {
			if (feof(before))
				eof_before = 1;
			else if (__read_sym(before, &buf, &bufsz, 0) < 0)
				break;
		}
		if (!eof_after) {
			if (feof(after))
				eof_after = 1;
			else if (__read_sym(after, &buf, &bufsz, 1) < 0)
				break;
		}
	}
	free(buf);
}

int main(int argc, char * const argv[])
{
	FILE *before, *after;

	if (argc > 3 || argc < 2)
		goto usage;
	if (strcmp(argv[1], "-"))
		before = fopen(argv[1], "r");
	else {
		before = stdin;
		if (!strcmp(argv[2], "-"))
			goto usage;
	}
	if (!strcmp(argv[2], "-") || argc == 2)
		after = stdin;
	else
		after = fopen(argv[2], "r");
	if (!before || !after)
		goto usage;
	table_init();
	read_syms(before, after);
	sym_cleanup();
	return 0;
usage:
	fprintf(stderr, "usage: %s profile [ profile ]\n", argv[0]);
	return EXIT_FAILURE;
}

--tqI+Z3u+9OQ7kwn0--
