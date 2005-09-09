Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbVIIUKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVIIUKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbVIIUKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:10:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47250 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030445AbVIIUKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:10:20 -0400
Date: Fri, 9 Sep 2005 21:10:18 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [sparse fix] (was Re: [PATCH] bogus cast in bio.c)
Message-ID: <20050909201018.GA9623@ZenIV.linux.org.uk>
References: <20050909155356.GF9623@ZenIV.linux.org.uk> <je4q8u1agp.fsf@sykes.suse.de> <20050909163643.GO9623@ZenIV.linux.org.uk> <20050909172938.GQ9623@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509091047530.3051@g5.osdl.org> <Pine.LNX.4.58.0509091114300.3051@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509091114300.3051@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 11:15:41AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 9 Sep 2005, Linus Torvalds wrote:
> > 
> > Ack. Applied,
> 
> Btw, I also just committed the fix to not warn for
> 
> 	#if defined(TOKEN) && TOKEN > 1
> 
> when TOKEN is undefined and -Wundef is enabled. Implemented exactly the
> way you suggested.

Cool...  Speaking of sparse patches:

* generates a warning when we cast _between_ address spaces (e.g. cast from
__user to __iomem).
* optional (on -Wcast-to-as) warning when casting _TO_ address space (e.g.
when normal pointer is cast to __iomem one - that caught a lot of crap in
drivers).  casts from unsigned long are still OK, so's cast from 0, so's
__force cast, of course.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff --git a/evaluate.c b/evaluate.c
--- a/evaluate.c
+++ b/evaluate.c
@@ -2049,11 +2049,27 @@ static int get_as(struct symbol *sym)
 	return as;
 }
 
+static void cast_to_as(struct expression *e, int as)
+{
+	struct expression *v = e->cast_expression;
+
+	if (!Wcast_to_address_space)
+		return;
+
+	/* cast from constant 0 to pointer is OK */
+	if (v->type == EXPR_VALUE && is_int_type(v->ctype) && !v->value)
+		return;
+
+	warning(e->pos, "cast adds address space to expression (<asn:%d>)", as);
+}
+
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
 	struct symbol *ctype = examine_symbol_type(expr->cast_type);
-	enum type type;
+	struct symbol *t1, *t2;
+	enum type type1, type2;
+	int as1, as2;
 
 	if (!target)
 		return NULL;
@@ -2092,51 +2108,54 @@ static struct symbol *evaluate_cast(stru
 	evaluate_expression(target);
 	degenerate(target);
 
+	t1 = ctype;
+	if (t1->type == SYM_NODE)
+		t1 = t1->ctype.base_type;
+	if (t1->type == SYM_ENUM)
+		t1 = t1->ctype.base_type;
+
 	/*
 	 * You can always throw a value away by casting to
 	 * "void" - that's an implicit "force". Note that
 	 * the same is _not_ true of "void *".
 	 */
-	if (ctype == &void_ctype)
+	if (t1 == &void_ctype)
 		goto out;
 
-	type = ctype->type;
-	if (type == SYM_NODE) {
-		type = ctype->ctype.base_type->type;
-		if (ctype->ctype.base_type == &void_ctype)
-			goto out;
-	}
-	if (type == SYM_ARRAY || type == SYM_UNION || type == SYM_STRUCT)
+	type1 = t1->type;
+	if (type1 == SYM_ARRAY || type1 == SYM_UNION || type1 == SYM_STRUCT)
 		warning(expr->pos, "cast to non-scalar");
 
-	if (!target->ctype) {
+	t2 = target->ctype;
+	if (!t2) {
 		warning(expr->pos, "cast from unknown type");
 		goto out;
 	}
+	if (t2->type == SYM_NODE)
+		t2 = t2->ctype.base_type;
+	if (t2->type == SYM_ENUM)
+		t2 = t2->ctype.base_type;
 
-	type = target->ctype->type;
-	if (type == SYM_NODE)
-		type = target->ctype->ctype.base_type->type;
-	if (type == SYM_ARRAY || type == SYM_UNION || type == SYM_STRUCT)
+	type2 = t2->type;
+	if (type2 == SYM_ARRAY || type2 == SYM_UNION || type2 == SYM_STRUCT)
 		warning(expr->pos, "cast from non-scalar");
 
-	if (!get_as(ctype) && get_as(target->ctype) > 0)
-		warning(expr->pos, "cast removes address space of expression");
-
-	if (!(ctype->ctype.modifiers & MOD_FORCE)) {
-		struct symbol *t1 = ctype, *t2 = target->ctype;
-		if (t1->type == SYM_NODE)
-			t1 = t1->ctype.base_type;
-		if (t2->type == SYM_NODE)
-			t2 = t2->ctype.base_type;
-		if (t1 != t2) {
-			if (t1->type == SYM_RESTRICT)
-				warning(expr->pos, "cast to restricted type");
-			if (t2->type == SYM_RESTRICT)
-				warning(expr->pos, "cast from restricted type");
-		}
+	if (!(ctype->ctype.modifiers & MOD_FORCE) && t1 != t2) {
+		if (t1->type == SYM_RESTRICT)
+			warning(expr->pos, "cast to restricted type");
+		if (t2->type == SYM_RESTRICT)
+			warning(expr->pos, "cast from restricted type");
 	}
 
+	as1 = get_as(ctype);
+	as2 = get_as(target->ctype);
+	if (!as1 && as2 > 0)
+		warning(expr->pos, "cast removes address space of expression");
+	if (as1 > 0 && as2 > 0 && as1 != as2)
+		warning(expr->pos, "cast between address spaces (<asn:%d>-><asn:%d>)", as2, as1);
+	if (as1 > 0 && !as2)
+		cast_to_as(expr, as1);
+
 	/*
 	 * Casts of constant values are special: they
 	 * can be NULL, and thus need to be simplified
diff --git a/lib.c b/lib.c
--- a/lib.c
+++ b/lib.c
@@ -170,6 +170,7 @@ int Wtypesign = 0;
 int Wcontext = 0;
 int Wundefined_preprocessor = 0;
 int Wptr_subtraction_blows = 0;
+int Wcast_to_address_space = 0;
 int Wtransparent_union = 1;
 int preprocess_only;
 char *include;
@@ -295,6 +296,7 @@ static const struct warning {
 	const char *name;
 	int *flag;
 } warnings[] = {
+	{ "cast-to-as", &Wcast_to_address_space },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "undef", &Wundefined_preprocessor },
diff --git a/lib.h b/lib.h
--- a/lib.h
+++ b/lib.h
@@ -79,6 +79,7 @@ extern int Wdefault_bitfield_sign;
 extern int Wundefined_preprocessor;
 extern int Wbitwise, Wtypesign, Wcontext;
 extern int Wtransparent_union;
+extern int Wcast_to_address_space;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
