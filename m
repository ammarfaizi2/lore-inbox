Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTIBAxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTIBAxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:53:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:55768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263376AbTIBAxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:53:11 -0400
Date: Mon, 1 Sep 2003 17:53:49 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse change to understand additional postix expressions.
Message-ID: <20030902005349.GA10260@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes a cast expression followed by an initializer list into
a postfix expression that can be dereferenced as a structure or an array.
There are approximately 7 instances of these expressions in the Linux kernel,
that give warnings about "expected lvalue for member dereference".

The approach involved introducing a new "stack-based temporary" symbol
of the same type as the cast expression, and using this as the target
of the initialization expression.  The subsequent array or structure
member dereferences are made to that temporary symbol.

show-parse.c need modification to display a symbol expression with
an initializer list that is NOT in a symbol declaration list.

An example of this form with structure member dereference is:

typedef struct { long t1; long t2; long t3; } longstruct_t;

long test;

int
main(void)
{
	int a, b, c;

	test = (longstruct_t){a, b, c}.t3;
	return 0;
}

An example of this form with array member dereference is:

typedef int iarray[2];
int pgp;

main(void)
{
	int index;
	int a, b;
	
	pgp = (iarray){a,b}[index];
}

diff -ur -X dontdiff sparse_original/evaluate.c sparse_patch2/evaluate.c
--- sparse_original/evaluate.c	2003-08-31 20:43:19.000000000 -0700
+++ sparse_patch2/evaluate.c	2003-08-31 21:01:38.000000000 -0700
@@ -1225,9 +1225,26 @@
 	 * initializer, in which case we need to pass
 	 * the type value down to that initializer rather
 	 * than trying to evaluate it as an expression
+	 *
+	 * A more complex case is when the initializer is
+	 * dereferenced as part of a post-fix expression.
+	 * We need to produce an expression that can be dereferenced.
 	 */
 	if (target->type == EXPR_INITIALIZER) {
-		evaluate_initializer(ctype, &expr->cast_expression, 0);
+		struct symbol *sym = alloc_symbol(expr->pos, SYM_NODE);
+		struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
+
+		sym->ctype.base_type = ctype;
+		sym->initializer = expr->cast_expression;
+		evaluate_symbol(sym);
+
+		addr->ctype = &ptr_ctype;
+		addr->symbol = sym;
+
+		expr->type = EXPR_PREOP;
+		expr->op = '*';
+		expr->unop = addr;
+		expr->ctype =  ctype;
 		return ctype;
 	}
 
diff -ur -X dontdiff sparse_original/expression.c sparse_patch2/expression.c
--- sparse_original/expression.c	2003-08-04 12:37:24.000000000 -0700
+++ sparse_patch2/expression.c	2003-09-01 16:54:48.000000000 -0700
@@ -241,11 +241,17 @@
 	return token;
 }
 
-static struct token *postfix_expression(struct token *token, struct expression **tree)
+/*
+ * extend to deal with the ambiguous C grammar for parsing
+ * a cast expressions followed by an initializer.
+ */
+static struct token *postfix_expression(struct token *token, struct expression **tree, struct expression *cast_init_expr)
 {
-	struct expression *expr = NULL;
+	struct expression *expr = cast_init_expr;
+
+	if (!expr)
+		token = primary_expression(token, &expr);
 
-	token = primary_expression(token, &expr);
 	while (expr && token_type(token) == TOKEN_SPECIAL) {
 		switch (token->special) {
 		case '[': {			/* Array dereference */
@@ -343,13 +349,16 @@
 						
 	}
 			
-	return postfix_expression(token, tree);
+	return postfix_expression(token, tree, NULL);
 }
 
 /*
  * Ambiguity: a '(' can be either a cast-expression or
  * a primary-expression depending on whether it is followed
  * by a type or not. 
+ *
+ * additional ambiguity: a "cast expression" followed by
+ * an initializer is really a postfix-expression.
  */
 static struct token *cast_expression(struct token *token, struct expression **tree)
 {
@@ -362,9 +371,11 @@
 			token = typename(next, &sym);
 			cast->cast_type = sym->ctype.base_type;
 			token = expect(token, ')', "at end of cast operator");
+			if (match_op(token, '{')) {
+				token = initializer(&cast->cast_expression, token);
+				return postfix_expression(token, tree, cast);
+			}
 			*tree = cast;
-			if (match_op(token, '{'))
-				return initializer(&cast->cast_expression, token);
 			token = cast_expression(token, &cast->cast_expression);
 			return token;
 		}
diff -ur -X dontdiff sparse_original/show-parse.c sparse_patch2/show-parse.c
--- sparse_original/show-parse.c	2003-08-04 12:37:25.000000000 -0700
+++ sparse_patch2/show-parse.c	2003-09-01 16:45:01.000000000 -0700
@@ -913,6 +913,15 @@
 	return 0;
 }
 
+int show_symbol_expr_init(struct symbol *sym)
+{
+	struct expression *expr = sym->initializer;
+
+	if (expr)
+		show_initializer_expr(expr, expr->ctype);
+	return show_symbol_expr(sym);
+}
+
 /*
  * Print out an expression. Return the pseudo that contains the
  * variable.
@@ -947,7 +956,7 @@
 	case EXPR_POSTOP:
 		return show_postop(expr);
 	case EXPR_SYMBOL:
-		return show_symbol_expr(expr->symbol);
+		return show_symbol_expr_init(expr->symbol);
 	case EXPR_DEREF:
 	case EXPR_SIZEOF:
 		warn(expr->pos, "invalid expression after evaluation");
