Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTCFP1C>; Thu, 6 Mar 2003 10:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTCFP1C>; Thu, 6 Mar 2003 10:27:02 -0500
Received: from angband.namesys.com ([212.16.7.85]:43152 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266888AbTCFP0i>; Thu, 6 Mar 2003 10:26:38 -0500
Date: Thu, 6 Mar 2003 18:37:05 +0300
From: Oleg Drokin <green@namesys.com>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Subject: Re: smatch update / 2.5.64 / kbugs.org
Message-ID: <20030306183705.A22846@namesys.com>
References: <20030306073727.2806.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306073727.2806.qmail@email.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 06, 2003 at 02:37:27AM -0500, dan carpenter wrote:

> The smatch bugs for kernel 2.5.64 are up.  The 
> new url for the smatch bug database is http://kbugs.org.  

Unfortunatelly the bug database does not work. I mean I cannot connect to it.

> One new script from Monday was "UnFree."  This check 
> looks for variables that aren't freed on the error paths.
> http://kbugs.org/cgi-bin/index.py?page=bug_list&script=UnFree&kernel=2.5.64

This is very interesting project, thanks a lot.
I spent some time on this today.
This script can produce a lot less false positives with even more custom merge rules.
Here's the diff that if run on fs/ext3/super.c from current bk tree, produces
only one true bug. (your version from cvs produces one real bug and two false positives)
(8 less hits on my default build).
Still there is a lot room for improvement of course (And probably I will spend some more time
on it), there are still valid cases left catched:
pointer assigned to some externally visible variable/structure before exit (fs/reiserfs/fix_node.c)
kmalloc only done conditionally (fs/reiserfs/namei.c)
probably more ;)

Also I think with this script it is somewhat easy to catch these cases (well, that needs to be coded of course):
loosing allocated pointer by assigning other value to variable and not storing old value anywhere.

Thank you.

Bye,
    Oleg
--- unfree.pl	Thu Mar  6 13:58:33 2003
+++ unfree-new.pl	Thu Mar  6 18:16:51 2003
@@ -12,6 +12,15 @@
     print get_filename(), " ", get_start_line($var), " ", get_lineno(), " ", get_func_pos(), " $msg\n";
 }
 
+
+sub merge_free_and_null($$$){
+    my ($name, $one, $two) = @_;
+
+    if ( ($one eq "free" && $two eq "null") || ($one eq "null" && $two eq "free") ) {
+	return "free";
+    }
+    return merge_rules($name, $one, $two);
+}
 sub merge_rules($$$){
     my ($name, $one, $two) = @_;
 
@@ -36,7 +45,7 @@
 
     return "undefined";
 }
-add_merge_function("merge_rules");
+add_merge_function("merge_free_and_null");
 
 while ($data = get_data()){
     my $tmp;
@@ -88,6 +97,11 @@
 		    set_true_path($name,"non_null");
 		}
 	    }
+	    if ( ! ($cond =~ /_expr/) && ! ($cond =~ /^compound_cond/) ) {
+		if (get_state ($cond)){
+		    set_true_path($cond,"non_null");
+		}
+	    }
 	}
 	for my $cond (@{$conds{falsepath}}){
 	    if ($cond =~ /eq_expr\(\((.*)\)\(integer_cst\(0\)\)\)/){
@@ -102,6 +116,11 @@
 		    set_false_path($name,"null");
 		}
 	    }
+	    if ( ! ($cond =~ /_expr/) && ! ($cond =~ /^compound_cond/) ) {
+		if (get_state ($cond)){
+		    set_false_path($cond,"null");
+		}
+	    }
 	}
     }elsif ($data =~ /^(do_cond) (.*)/){            # check do while() for thouroughness
 	$conds = split_conds($1);
@@ -119,11 +138,23 @@
 		}
 	    }
 	}
+	if ( ! ($cond =~ /_expr/) && ! ($cond =~ /^compound_cond/) ) {
+	    if (get_state ($cond)){
+		set_state($cond,"null");
+	    }
+	}
     }
     
     if ($data =~ /call_expr\(\(addr_expr function_decl\(kfree\)\)\(tree_list: (.*)\)\)/){
 	my $var = $1;
-	if (get_state($var)){
+	my $state = get_state($var);
+	if ( !($state =~ /non_null/) && $state =~ /null/ ) {
+	    error_msg("Freeing null pointer", $state);
+	}
+	if ( $state =~ /free/ ) {
+	    error_msg("Freeing already freed", $state);
+	}
+	if ($state){
 	    set_state($var, "free");
 	}
     }
