Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTFGAmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFGAmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:42:36 -0400
Received: from dp.samba.org ([66.70.73.150]:6813 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262434AbTFGAma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:42:30 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.14183.729684.757477@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 10:52:55 +1000
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <20030607004208.GA4506@mars.ravnborg.org>
References: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com>
	<Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>
	<16097.12932.161268.783738@argo.ozlabs.ibm.com>
	<20030607004208.GA4506@mars.ravnborg.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg writes:

> Cloned it today - compiled without a single warning.
> (RH8.0, gcc 3.2)

Hmmm, I am using gcc 3.3 (debian sid).

> My version looks like this:
>         struct preprocessor_sym {
>                 struct token *expansion;
>                 struct token *arglist;
>         };  <= line 73

So does mine.

>         struct ctype_sym {
> 
> Looks like something wrong at your side...

Well, does symbol.h have a `ctype' member in your copy?  It doesn't in
mine.  And line 44 of parse.c says:

        sym->ctype.base_type = ctype->base_type;

which fails because sym is a struct symbol * and struct symbol doesn't
have a ctype member.  And FWIW the compilation fails with gcc-3.2 too.

I have included the version of symbol.h that I have below.  Could you
compare that against yours and/or do a pull and see if it still works
for you?

Paul.

#ifndef SYMBOL_H
#define SYMBOL_H
/*
 * Basic symbol and namespace definitions.
 *
 * Copyright (C) 2003 Transmeta Corp.
 *
 *  Licensed under the Open Software License version 1.1
 */

#include "token.h"

/*
 * An identifier with semantic meaning is a "symbol".
 *
 * There's a 1:n relationship: each symbol is always
 * associated with one identifier, while each identifier
 * can have one or more semantic meanings due to C scope
 * rules.
 *
 * The progression is symbol -> token -> identifier. The
 * token contains the information on where the symbol was
 * declared.
 */
enum namespace {
	NS_NONE,
	NS_PREPROCESSOR,
	NS_TYPEDEF,
	NS_STRUCT,
	NS_ENUM,
	NS_LABEL,
	NS_SYMBOL,
	NS_ITERATOR,
};

enum type {
	SYM_BASETYPE,
	SYM_NODE,
	SYM_PTR,
	SYM_FN,
	SYM_ARRAY,
	SYM_STRUCT,
	SYM_UNION,
	SYM_ENUM,
	SYM_TYPEDEF,
	SYM_TYPEOF,
	SYM_MEMBER,
	SYM_BITFIELD,
	SYM_LABEL,
};

struct ctype {
	unsigned long modifiers;
	unsigned long alignment;
	unsigned int contextmask, context, as;
	struct symbol *base_type;
};

struct symbol {
	enum namespace namespace:8;
	enum type type:8;
	struct position pos;		/* Where this symbol was declared */
	struct ident *ident;		/* What identifier this symbol is associated with */
	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
	struct symbol **id_list;	/* Backpointer to symbol list head */
	struct scope	*scope;
	struct symbol	*same_symbol;
	int (*evaluate)(struct expression *);

	struct preprocessor_sym {
		struct token *expansion;
		struct token *arglist;
	};
	
	struct ctype_sym {
		unsigned long	offset;
		unsigned int	bit_size;
		unsigned int	bit_offset:8,
				fieldwidth:8,
				arg_count:10,
				variadic:1,
				used:1,
				initialized:1;
		int	array_size;
		struct ctype ctype;
		struct symbol_list *arguments;
		struct statement *stmt;
		struct symbol_list *symbol_list;
		struct expression *initializer;
		long long value;		/* Initial value */
	};
	void *aux;				/* Auxiliary info, eg. backend information */
};

/* Modifiers */
#define MOD_AUTO	0x0001
#define MOD_REGISTER	0x0002
#define MOD_STATIC	0x0004
#define MOD_EXTERN	0x0008

#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL)

#define MOD_CONST	0x0010
#define MOD_VOLATILE	0x0020
#define MOD_SIGNED	0x0040
#define MOD_UNSIGNED	0x0080

#define MOD_CHAR	0x0100
#define MOD_SHORT	0x0200
#define MOD_LONG	0x0400
#define MOD_LONGLONG	0x0800

#define MOD_TYPEDEF	0x1000
#define MOD_STRUCTOF	0x2000
#define MOD_UNIONOF	0x4000
#define MOD_ENUMOF	0x8000

#define MOD_TYPEOF	0x10000
#define MOD_ATTRIBUTE	0x20000
#define MOD_INLINE	0x40000
#define MOD_ADDRESSABLE	0x80000

#define MOD_NOCAST	0x100000
#define MOD_NODEREF	0x200000
#define MOD_ACCESSED	0x400000
#define MOD_TOPLEVEL	0x800000	// scoping..

#define MOD_LABEL	0x1000000

/* Basic types */
extern struct symbol	void_type,
			int_type,
			label_type,
			fp_type,
			vector_type,
			bad_type;

/* C types */
extern struct symbol	bool_ctype, void_ctype,
			char_ctype, uchar_ctype,
			short_ctype, ushort_ctype,
			int_ctype, uint_ctype,
			long_ctype, ulong_ctype,
			llong_ctype, ullong_ctype,
			float_ctype, double_ctype, ldouble_ctype,
			string_ctype, ptr_ctype, label_type;


/* Basic identifiers */
extern struct ident	sizeof_ident,
			alignof_ident,
			__alignof_ident,
			__alignof___ident,
			if_ident,
			else_ident,
			switch_ident,
			case_ident,
			default_ident,
			break_ident,
			continue_ident,
			for_ident,
			while_ident,
			do_ident,
			goto_ident,
			return_ident;

extern struct ident	__asm___ident,
			__asm_ident,
			asm_ident,
			__volatile___ident,
			__volatile_ident,
			volatile_ident,
			__attribute___ident,
			__attribute_ident,
			pragma_ident;

#define symbol_is_typename(sym) ((sym)->type == SYM_TYPE)

extern struct symbol_list *used_list;

extern void access_symbol(struct symbol *);


extern struct symbol *lookup_symbol(struct ident *, enum namespace);
extern void init_symbols(void);
extern struct symbol *alloc_symbol(struct position, int type);
extern void show_type(struct symbol *);
extern const char *modifier_string(unsigned long mod);
extern void show_symbol(struct symbol *);
extern void show_type_list(struct symbol *);
extern void show_symbol_list(struct symbol_list *, const char *);
extern void add_symbol(struct symbol_list **, struct symbol *);
extern void bind_symbol(struct symbol *, struct ident *, enum namespace);

extern struct symbol *examine_symbol_type(struct symbol *);
extern void examine_simple_symbol_type(struct symbol *);
extern const char *show_typename(struct symbol *sym);

extern void debug_symbol(struct symbol *);
extern void merge_type(struct symbol *sym, struct symbol *base_type);
extern void check_declaration(struct symbol *sym);

#endif /* SEMANTIC_H */
