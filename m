Return-Path: <linux-kernel-owner+w=401wt.eu-S932253AbXADEuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbXADEuR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbXADEuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:50:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43012 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253AbXADEuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:50:15 -0500
Date: Thu, 4 Jan 2007 05:46:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: "Chen, Tim C" <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104044659.GA3097@elte.hu>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com> <20061229232618.GA11239@gnuppy.monkey.org> <20061230111940.GA8412@elte.hu> <20070103074124.GA25594@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103074124.GA25594@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> >  - Documentation/CodingStyle compliance - the code is not ugly per se
> >    but still looks a bit 'alien' - please try to make it look Linuxish,
> >    if i apply this we'll probably stick with it forever. This is the
> >    major reason i havent applied it yet.
> 
> I reformatted most of the patch to be 80 column limited. I simplified 
> a number of names, but I'm open to suggestions and patches to how to 
> go about this. Much of this code was a style experiment, but now I 
> have to make this more mergable.

thanks. It's looking better, but there's still quite a bit of work left:

there's considerable amount of whitespace noise in it - lots of lines 
with space/tab at the end, lines with 8 spaces instead of tabs, etc.

comment style issues:

+/* To be use for avoiding the dynamic attachment of spinlocks at runtime
+ * by attaching it inline with the lock initialization function */

the proper multi-line style is:

/*
 * To be used for avoiding the dynamic attachment of spinlocks at 
 * runtime by attaching it inline with the lock initialization function:
 */

(note i also fixed a typo in the one above)

more unused code:

+/*
+static DEFINE_LS_ENTRY(__pte_alloc);
+static DEFINE_LS_ENTRY(get_empty_filp);
+static DEFINE_LS_ENTRY(init_waitqueue_head);
...
+*/

these:

+static int lock_stat_inited = 0;

should not be initialized to 0, that is implicit for static variables.

weird alignment here:

+void lock_stat_init(struct lock_stat *oref)
+{
+       oref->function[0]       = 0;
+       oref->file      = NULL;
+       oref->line      = 0;
+
+       oref->ntracked  = 0;

funky branching:

+       spin_lock_irqsave(&free_store_lock, flags);
+       if (!list_empty(&lock_stat_free_store)) {
+               struct list_head *e = lock_stat_free_store.next;
+               struct lock_stat *s;
+
+               s = container_of(e, struct lock_stat, list_head);
+               list_del(e);
+
+               spin_unlock_irqrestore(&free_store_lock, flags);
+
+               return s;
+       }
+       spin_unlock_irqrestore(&free_store_lock, flags);
+
+       return NULL;

that should be s = NULL in the function scope and a plain unlock and 
return s.

assignments mixed with arithmetics:

+static
+int lock_stat_compare_objs(struct lock_stat *x, struct lock_stat *y)
+{
+       int a = 0, b = 0, c = 0;
+
+       (a = ksym_strcmp(x->function, y->function))     ||
+       (b = ksym_strcmp(x->file, y->file))             ||
+       (c = (x->line - y->line));
+
+       return a | b | c;

the usual (and more readable) style is to separate them out explicitly:

	a = ksym_strcmp(x->function, y->function);
	if (!a)
		return 0;
	b = ksym_strcmp(x->file, y->file);
	if (!b)
		return 0;

	return x->line == y->line;

(detail: this btw also fixes a bug in the function above AFAICS, in the 
a && !b case.)

also, i'm not fully convinced we want that x->function as a string. That 
makes comparisons alot slower. Why not make it a void *, and resolve to 
the name via kallsyms only when printing it in /proc, like lockdep does 
it?

no need to put dates into comments:

+        * Fri Oct 27 00:26:08 PDT 2006

then:

+       while (node)
+       {

proper style is:

+	while (node) {

this function definition:

+static
+void lock_stat_insert_object(struct lock_stat *o)

can be single-line. We make it multi-line only when needed.

these are only samples of the types of style problems still present in 
the code.

	Ingo
