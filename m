Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRG1WWc>; Sat, 28 Jul 2001 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbRG1WWY>; Sat, 28 Jul 2001 18:22:24 -0400
Received: from zeus.kernel.org ([209.10.41.242]:25796 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267140AbRG1WWP>;
	Sat, 28 Jul 2001 18:22:15 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200107282206.AAA10907@green.mif.pg.gda.pl>
Subject: [PATCH] more xconfig option elimination
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Sun, 29 Jul 2001 00:06:00 +0200 (CEST)
Cc: esr@thyrsus.com, chastain@cygnus.com (Michael Elizabeth Chastain)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi
   The following patch is an attempt to eliminate options for non-current
architecture, disabled in another way than using "if [ ARCH = ..."
I hoped I would never finish this work as it wouldn't be needed.

But as:
1. ARCH = ... conditions are already almost not used; CONFIG_ARCH_* = ...
   are preferred now,
2. potential 2.5/CML2 backport to 2.4 is still far,
3. some architecture specyfic configs have been merged into the main tree
   last time
I think this code may be usefull for novices. Please test.

The effect of this patch against 2.4.7 is shown in the table below.

ARCH    --- eliminated ------     total
        new   old  difference     options

alpha    74    54   20            1443
arm      60    36   24            1476
cris    125   117    8            1454
i386     61    48   13            1514
ia64     97    52   45            1432
m68k     19    10    9             708
mips     70    50   20            1523
mips64   72    52   20            1479
parisc   24    24    0             893
ppc      80    35   45            1537
s390      0     0    0             283
s390x     0     0    0             284
sh       77    53   24            1174
sparc    30    19   11             697
sparc64  76    37   39            1044


Andrzej

*******************************************************************
diff -ur scripts.old/tkcond.c scripts/tkcond.c
--- scripts.old/tkcond.c	Sat Jul 28 23:00:57 2001
+++ scripts/tkcond.c	Sat Jul 28 22:58:00 2001
@@ -20,6 +20,9 @@
  *   implemented.
  * - negation (!) eliminated from conditions
  *
+ * 25 July 2001, Andrzej M. Krzysztofowicz <ankry@mif.pg.gda.pl>
+ * - eliminating some (parts of) conditions with values known at parse time
+ *
  * TO DO:
  * - xconfig is at the end of its life cycle.  Contact <mec@shout.net> if
  *   you are interested in working on the replacement.
@@ -281,14 +284,31 @@
 
 
 
+static int ynm_strcmp( const char *s1, const char *s2)
+{
+    if ( !strcmp( s2, "CONSTANT_N") )
+	return strcmp( s1, "n" ) && strcmp( s1, "N" );
+    else if ( !strcmp( s2, "CONSTANT_M") )
+	return strcmp( s1, "m" ) && strcmp( s1, "M" );
+    else if ( !strcmp( s2, "CONSTANT_Y") )
+	return strcmp( s1, "y" ) && strcmp( s1, "Y" );
+    else if ( !strcmp( s2, "CONSTANT_E") )
+	return strcmp( s1, "" );
+    else
+	return strcmp( s1, s2 );
+}
+
+
+
 static char * current_arch = NULL;
 
 /*
- * Eliminating conditions with ARCH = <not current>.
+ * Eliminating parts of conditions with ARCH = <not current> 
+ * and CONFIG_DEFINED_VAR = <value_other_than_defined>.
  */
-static struct condition *eliminate_other_arch( struct condition *list )
+static struct condition *parse_eliminate_part( struct condition *list )
 {
-    struct condition *cond1a = list, *cond1b = NULL, *cond1c = NULL, *cond1d = NULL;
+    struct condition *cond1a = list, *cond1b = NULL, *cond1c = NULL;
     if ( current_arch == NULL )
 	current_arch = getenv( "ARCH" );
     if ( current_arch == NULL )
@@ -301,117 +321,341 @@
     {
 	cond1b = cond1a->next; if ( cond1b == NULL ) goto done;
 	cond1c = cond1b->next; if ( cond1c == NULL ) goto done;
-	cond1d = cond1c->next;
-	if ( cond1c->op == op_constant && cond1d == NULL )
+	if ( cond1c->op == op_constant )
 	{
 	    if ( (cond1b->op == op_eq && strcmp( cond1c->str, current_arch ))
 	    ||   (cond1b->op == op_neq && ! strcmp( cond1c->str, current_arch )) )
-	    {
 		/* This is for another architecture */ 
-		cond1a->op = op_false;
-		cond1a->next = NULL;
-		free_cond( cond1b );
-		return cond1a;
-	    }
+		cond1c->op = op_false;
 	    else if ( (cond1b->op == op_neq && strcmp( cond1c->str, current_arch ))
-		 ||   (cond1b->op == op_eq && ! strcmp( cond1c->str, current_arch )) )
-	    {
+		 || (cond1b->op == op_eq && ! strcmp( cond1c->str, current_arch )) )
 		/* This is for current architecture */
-		cond1a->op = op_true;
-		cond1a->next = NULL;
-		free_cond( cond1b );
-		return cond1a;
+		cond1c->op = op_true;
+	    if ( cond1b->op == op_eq || cond1b->op == op_neq )
+	    {
+		cond1c->str = NULL;
+		cond1b->next = NULL;
+		free_cond( cond1a );
+		return cond1c;
 	    }
 	}
-	else if ( cond1c->op == op_constant && cond1d->op == op_or )
+    }
+    else if ( cond1a->op == op_variable && ! vartable[cond1a->nameindex].defined )
+    {
+	cond1b = cond1a->next; if ( cond1b == NULL ) goto done;
+	cond1c = cond1b->next; if ( cond1c == NULL ) goto done;
+	if ( cond1c->op == op_constant )
 	{
-	    if ( (cond1b->op == op_eq && strcmp( cond1c->str, current_arch ))
-	    ||   (cond1b->op == op_neq && ! strcmp( cond1c->str, current_arch )) )
+	    if ( (cond1b->op == op_eq && strcmp( cond1c->str, "" ))
+	    ||   (cond1b->op == op_neq && ! strcmp( cond1c->str, "" )) )
+		cond1c->op = op_false;
+	    else if ( (cond1b->op == op_neq && strcmp( cond1c->str, "" ))
+	    ||   (cond1b->op == op_eq && ! strcmp( cond1c->str, "" )) )
+		cond1c->op = op_true;
+	    if ( cond1b->op == op_eq || cond1b->op == op_neq )
 	    {
-		/* This is for another architecture */ 
-		cond1b = cond1d->next;
-		cond1d->next = NULL;
+		cond1c->str = NULL;
+		cond1b->next = NULL;
 		free_cond( cond1a );
-		return eliminate_other_arch( cond1b );
+		return cond1c;
 	    }
-	    else if ( (cond1b->op == op_neq && strcmp( cond1c->str, current_arch ))
-		 || (cond1b->op == op_eq && ! strcmp( cond1c->str, current_arch )) )
+	}
+    }
+    else if ( cond1a->op == op_variable
+         && vartable[cond1a->nameindex].constant == 1 )
+    {
+	cond1b = cond1a->next; if ( cond1b == NULL ) goto done;
+	cond1c = cond1b->next; if ( cond1c == NULL ) goto done;
+	if ( cond1c->op == op_constant  )
+	{
+	    if ( (cond1b->op == op_eq
+	         && ynm_strcmp( cond1c->str, vartable[cond1a->nameindex].value ))
+	    ||   (cond1b->op == op_neq
+	         && ! ynm_strcmp( cond1c->str, vartable[cond1a->nameindex].value )) )
+		/* This is for another value than the defined for this variable */ 
+		cond1c->op = op_false;
+	    else if ( (cond1b->op == op_neq
+	              && ynm_strcmp( cond1c->str, vartable[cond1a->nameindex].value ))
+		 ||   (cond1b->op == op_eq
+		      && ! ynm_strcmp( cond1c->str, vartable[cond1a->nameindex].value )) )
+		/* This is for the defined value of this variable; can be omitted */
+		cond1c->op = op_true;
+	    if ( cond1b->op == op_eq || cond1b->op == op_neq )
 	    {
-		/* This is for current architecture */
-		cond1a->op = op_true;
-		cond1a->next = NULL;
-		free_cond( cond1b );
-		return cond1a;
+		cond1c->str = NULL;
+		cond1b->next = NULL;
+		free_cond( cond1a );
+		return cond1c;
 	    }
 	}
-	else if ( cond1c->op == op_constant && cond1d->op == op_and )
+    }
+done:
+    return list;
+}
+
+
+
+/*
+ * Extracting an expresion from condition; returns its last element.
+ */
+static struct condition *xtract_expr( struct condition *list )
+{
+    struct condition *conda, *condb;
+
+    if ( list->op == op_true || list->op == op_false )
+    {
+	condb = list;
+	return condb;
+    }
+    else
+    {
+	conda = list->next; if ( ! conda ) return list;
+	condb = conda->next; if ( ! condb ) return list;
+	if ( list->op == op_variable
+	&&   ( conda->op == op_eq || conda->op == op_neq )
+	&&   ( condb->op == op_constant || condb->op == op_variable ) )
 	{
-	    if ( (cond1b->op == op_eq && strcmp( cond1c->str, current_arch ))
-	    ||   (cond1b->op == op_neq && ! strcmp( cond1c->str, current_arch )) )
+	    return condb;
+	}
+	else if ( list->op == op_lparen )
+	{
+	    int level = 1;
+	    for ( conda = list->next, condb = list; level > 0;
+		  condb = conda, conda = condb->next )
 	    {
-		/* This is for another architecture */
-		int l_par = 0;
-		
-		for ( cond1c = cond1d->next; cond1c; cond1c = cond1c->next )
-		{
-		    if ( cond1c->op == op_lparen )
-			l_par++;
-		    else if ( cond1c->op == op_rparen )
-			l_par--;
-		    else if ( cond1c->op == op_or && l_par == 0 )
-		    /* Expression too complex - don't touch */
-			return cond1a;
-		    else if ( l_par < 0 )
-		    {
-			fprintf( stderr, "incorrect condition: programming error ?\n" );
-			exit( 1 );
-		    }
+		if ( ! conda )
+		{
+		    fprintf( stderr, "error in condition: brackets not paired\n" );
+		    exit( 1 );
 		}
-		cond1a->op = op_false;
-		cond1a->next = NULL;
-		free_cond( cond1b );
-		return cond1a;
-	    }
-	    else if ( (cond1b->op == op_neq && strcmp( cond1c->str, current_arch ))
-		 || (cond1b->op == op_eq && ! strcmp( cond1c->str, current_arch )) )
-	    {
-		/* This is for current architecture */
-		cond1b = cond1d->next;
-		cond1d->next = NULL;
-		free_cond( cond1a );
-		return eliminate_other_arch( cond1b );
+		else if ( conda->op == op_lparen )
+		    level ++;
+		else if ( conda->op == op_rparen )
+		    level --;
 	    }
+	    return condb;
 	}
+	else
+	    return NULL;
     }
-    if ( cond1a->op == op_variable && ! vartable[cond1a->nameindex].defined )
+}
+
+
+
+/*
+ * Removing an expresion from beginning of the condition.
+ */
+static struct condition *skip_expr( struct condition *list )
+{
+    struct condition *conda, *condb;
+
+    condb = xtract_expr( list );
+    if ( condb )
     {
-	cond1b = cond1a->next; if ( cond1b == NULL ) goto done;
-	cond1c = cond1b->next; if ( cond1c == NULL ) goto done;
-	cond1d = cond1c->next;
+	conda = condb->next;
+	condb->next = NULL;
+	free_cond( list );
+	return conda;
+    }
+    return list;
+}
 
-	if ( cond1c->op == op_constant
-	&& ( cond1d == NULL || cond1d->op == op_and ) ) /*???*/
+
+
+/*
+ * Finding beginning of previous expr.
+ * Returns start of the previous expression and sets *cond to
+ * the preceiding operator (or NULL if there is none).
+ */
+static struct condition *skip_one_back( struct condition **cond, struct condition *list )
+{
+    struct condition *conda, *condb, *prev = NULL;
+
+    for ( conda = list; conda; prev = conda, conda = conda->next )
+    {
+	if ( conda->op == op_lparen || conda->op == op_variable ||
+	     conda->op == op_true || conda->op == op_false )
 	{
-	    if ( cond1b->op == op_eq && strcmp( cond1c->str, "" ) )
+	    condb = xtract_expr( conda );
+	    if ( condb && condb->next == *cond )
+	    {
+		*cond = prev;
+		return conda;
+	    }
+	}
+    }	
+    return NULL;
+}
+
+
+
+/*
+ * Finding previous "-o".
+ * Returns start of the previous expression and sets *cond to
+ * the preceiding operator (or NULL if there is none).
+ */
+static struct condition *skip_conj_back( struct condition **cond, struct condition *list )
+{
+    struct condition *prev = NULL;
+
+    {
+	prev = skip_one_back( cond, list );
+    } while ( *cond && (*cond)->op == op_and );
+    return prev;
+}
+
+
+
+/*
+ * Eliminating obviously true and obviously false conditions.
+ */
+static struct condition *eliminate_unneeded( struct condition *list, int level )
+{
+    struct condition *conda = list, *condb = NULL, *condc = NULL, *prev = NULL;
+    int start, eliminated = 1;
+
+    list = parse_eliminate_part( list );
+    for ( conda = list; conda && conda->next; conda = conda->next )
+    {
+	if ( conda->op == op_and || conda->op == op_or
+	||   conda->op == op_lparen )
+	    conda->next = parse_eliminate_part( conda->next );
+    }
+    while (eliminated)
+    {
+	eliminated = 0;
+	start = 1;
+	for ( conda = list; conda && conda->next;
+	      prev = conda, conda = conda->next, start = 0 )
+	{
+repeat:
+	    condb = conda->next; if ( condb == NULL ) goto done;
+	    condc = condb->next; if ( condc == NULL ) goto done;
+	    if ( conda->op == op_lparen )
+	    {
+		conda->next = eliminate_unneeded( conda->next, level + 1 );
+		condb = conda->next; if ( condb == NULL ) goto done;
+		condc = condb->next; if ( condc == NULL ) goto done;
+		if ( conda->op == op_lparen
+		&&  (condb->op == op_true || condb->op == op_false) 
+		&&   condc->op == op_rparen )
+		{
+		    conda->op = condb->op;
+		    conda->next = condc->next;
+		    condc->next = NULL;
+		    free_cond( condb );
+		    eliminated = 1;
+		}
+	    }
+	    else if ( level > 0 && conda->op == op_rparen )
+		goto done;
+	    else if ( (conda->op == op_false && condb->op == op_or && start)
+		 ||   (conda->op == op_true && condb->op == op_and) )
+	    {
+		condb->next = NULL;
+		free_cond( conda );
+		conda = condc;
+		if (start)
+		    list = conda;
+		else
+		    prev->next = conda;
+		eliminated = 1;
+		goto repeat;
+	    }
+	    else if ( (conda->op == op_false && condb->op == op_and)
+		 ||   (conda->op == op_true && condb->op == op_or && start) )
+	    {
+		condb->next = NULL;
+		free_cond( condb );
+		conda->next = skip_expr( condc );
+		eliminated = 1;
+	    }
+	    else if ( conda->op == op_or && condb->op == op_true
+	         &&   condc->op == op_or )
+	    {
+		condb->next = skip_expr( condc->next );
+		condc->next = NULL;
+		free_cond( condc );
+		eliminated = 1;
+		goto repeat;
+	    }
+	    else if ( conda->op == op_or && condb->op == op_false
+	         &&   condc->op == op_or )
+	    {
+		conda->next = condc->next;
+		condc->next = NULL;
+		free_cond( condb );
+		eliminated = 1;
+	    }
+	    else if ( conda->op == op_and && condb->op == op_true )
 	    {
-		cond1a->op = op_false;
-		cond1a->next = NULL;
-		free_cond( cond1b );
-		return cond1a;
+		prev->next = condc;
+		condb->next = NULL;
+		free_cond( conda );
+		eliminated = 1;
+		goto done2;
+	    }
+	    else if ( conda->op == op_and && condb->op == op_false )
+	    {
+		condc = conda;
+		prev = skip_one_back( &condc, list );
+		if ( prev )
+		{
+		    conda->next = NULL;
+		    if ( condc )
+			condc->next = condb;
+		    else
+			list = condb;
+		    free_cond( prev );
+		    eliminated = 1;
+		    goto done2;
+		}
+	    }
+	}
+done:
+	/* Processing elimination at the end of the expresion */
+	if ( conda && ((conda->op == op_and && condb && condb->op == op_true)
+	||   (conda->op == op_or && condb && condb->op == op_false &&
+	     (!condc || condc->op != op_and))) )
+	{
+	    prev->next = condc;
+	    condb->next = NULL;
+	    free_cond( conda );
+	    eliminated = 1;
+	}
+	else if ( conda && conda->op == op_and && condb && condb->op == op_false )
+	{	
+	    condc = conda;
+	    prev = skip_one_back( &condc, list );
+	    if ( prev )
+	    {
+		conda->next = NULL;
+		if ( condc )
+		    condc->next = condb;
+		else
+		    list = condb;
+		free_cond( prev );
+		eliminated = 1;
 	    }
 	}
-	else if ( cond1c->op == op_constant && cond1d->op == op_or )
+	else if ( conda && conda->op == op_or && condb && condb->op == op_true
+	     &&   (!condc || condc->op != op_and) )
 	{
-	    if ( cond1b->op == op_eq && strcmp( cond1c->str, "" ) )
+	    condc = conda;
+	    prev = skip_conj_back( &condc, list );
+	    if ( prev )
 	    {
-		cond1b = cond1d->next;
-		cond1d->next = NULL;
-		free_cond( cond1a );
-		return eliminate_other_arch( cond1b );
+		conda->next = NULL;
+		if ( condc )
+		    condc->next = condb;
+		else
+		    list = condb;
+		free_cond( prev );
+		eliminated = 1;
 	    }
 	}
+done2:;
     }
-done:
     return list;
 }
 
@@ -453,7 +697,7 @@
 
 	    case token_if:
 		cond_stack [depth++] =
-		    remove_bang( eliminate_other_arch( cfg->cond ) );
+		    remove_bang( eliminate_unneeded( cfg->cond, 0 ) );
 		cfg->cond = NULL;
 		break;
 
@@ -490,15 +734,20 @@
 		--depth;
 		break;
 
-	    case token_bool:
-	    case token_choice_item:
-	    case token_choice_header:
-	    case token_comment:
 	    case token_define_bool:
 	    case token_define_hex:
 	    case token_define_int:
 	    case token_define_string:
 	    case token_define_tristate:
+		if ( cfg->cond == NULL && cfg->nameindex > 0 )
+		{
+		    vartable[cfg->nameindex].constant --;
+		    vartable[cfg->nameindex].value = cfg->value;
+		}
+	    case token_bool:
+	    case token_choice_item:
+	    case token_choice_header:
+	    case token_comment:
 	    case token_endmenu:
 	    case token_hex:
 	    case token_int:
@@ -506,6 +755,8 @@
 	    case token_string:
 	    case token_tristate:
 	    case token_unset:
+		if ( cfg->nameindex > 0 )
+		    vartable[cfg->nameindex].constant += 2;
 		cfg->cond = join_condition_stack( cond_stack, depth );
 		if ( cfg->cond && cfg->cond->op == op_false )
 		{
@@ -524,9 +775,11 @@
 		 * Same as the other simple statements, plus an additional
 		 * condition for the dependency.
 		 */
+		if ( cfg->nameindex > 0 )
+		    vartable[cfg->nameindex].constant += 2;
 		if ( cfg->cond )
 		{
-		    cond_stack [depth] = eliminate_other_arch( cfg->cond );
+		    cond_stack [depth] = eliminate_unneeded( cfg->cond, 0 );
 		    cfg->cond = join_condition_stack( cond_stack, depth+1 );
 		}
 		else
@@ -536,7 +789,7 @@
 		if ( cfg->cond && cfg->cond->op == op_false )
 		{
 		    good = 0;
-	    if ( prev )
+		    if ( prev )
 			prev->next = cfg->next;
 		    else
 			scfg = cfg->next;
@@ -565,7 +818,7 @@
 	    printf( " %s", vartable[tmp->nameindex].name );
 	    break;
 	case op_constant: 
-	    printf( " %s", tmp->str );
+	    printf( " \"%s\"", tmp->str );
 	    break;
 	case op_eq:
 	    printf( " =" );
diff -ur scripts.old/tkgen.c scripts/tkgen.c
--- scripts.old/tkgen.c	Sat May 19 18:36:21 2001
+++ scripts/tkgen.c	Sat Jul 28 23:08:21 2001
@@ -356,6 +356,17 @@
 	case op_lparen: printf( "("    ); break;
 	case op_rparen: printf( ")"    ); break;
 
+	/* 
+	 * These shouldn't appear here. Just workaround for the case when
+	 * something else is bad.
+	 */
+	case op_true:   printf( "\"1\" == \"1\""    );
+	    fprintf( stderr, "Condition optimization problem\n" );
+	    break;
+	case op_false:  printf( "\"1\" == \"0\""    );
+	    fprintf( stderr, "Condition optimization problem\n" );
+	    break;
+
 	case op_variable:
 	    printf( "$%s", vartable[cond->nameindex].name );
 	    break;
@@ -722,6 +733,17 @@
 	    case op_or:        printf( " || " ); break;
 	    case op_lparen:    printf( "("    ); break;
 	    case op_rparen:    printf( ")"    ); break;
+
+	    /* 
+	     * These shouldn't appear here. Just workaround for the case when
+	     * something else is bad.
+	     */
+	    case op_true:   printf( "\"1\" == \"1\""    );
+		fprintf( stderr, "Condition optimization problem\n" );
+		break;
+	    case op_false:  printf( "\"1\" == \"0\""    );
+		fprintf( stderr, "Condition optimization problem\n" );
+		break;
 
 	    case op_variable:
 		printf( "$%s", vartable[cond->nameindex].name );
diff -ur scripts.old/tkparse.h scripts/tkparse.h
--- scripts.old/tkparse.h	Mon Feb 21 05:13:10 2000
+++ scripts/tkparse.h	Tue Jul  3 21:39:57 2001
@@ -113,6 +113,8 @@
     char *	name;
     char	defined;
     char	global_written;
+    int		constant;
+    char *	value;
 };
 
 extern struct variable vartable[];


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
