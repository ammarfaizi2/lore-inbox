Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTANQtL>; Tue, 14 Jan 2003 11:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTANQtL>; Tue, 14 Jan 2003 11:49:11 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:16603 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264711AbTANQtK>;
	Tue, 14 Jan 2003 11:49:10 -0500
Date: Tue, 14 Jan 2003 17:58:01 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa2
Message-ID: <20030114165801.GC1792@werewolf.able.es>
References: <20021226102814.GB6938@dualathlon.random> <20030114122334.GE919@holomorphy.com> <20030114161218.GD19700@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030114161218.GD19700@dualathlon.random>; from andrea@suse.de on Tue, Jan 14, 2003 at 17:12:18 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.14 Andrea Arcangeli wrote:
> On Tue, Jan 14, 2003 at 04:23:34AM -0800, William Lee Irwin III wrote:
> > On Thu, Dec 26, 2002 at 11:28:14AM +0100, Andrea Arcangeli wrote:
> > > I'm leaving for vacations in 5 minutes so hopefully this will compile
> > > for everybody ;) [I know, mylex still doesn't compile without backing
> > > out the elevator-lowlatency patch but I hadn't time to fix it yet], I'll
> > > be back online on 3 Jan.
> > 
> > Hmm. Where is init_one_highpage() defined?
> 
> I assumed it got dropped while upgrading to new mainline trees, Marcelo
> merged parts of the arch init cleanup and probably init_one_highpage was
> missing from those patches merged in mainline despite most other things
> were present. Thanks for the info (I will now go find where it was lost).
> 

Perhaps it is just a mutant ?

vi +449 arch/i386/mm/init.c

BTW, could you apply this, to get in sync with 2.5 ?

--- linux-2.4.20-pre5/arch/i386/mm/init.c	Tue Aug 20 11:36:59 2002
+++ linux/arch/i386/mm/init.c	Fri Sep  6 13:14:37 2002
@@ -442,21 +442,14 @@ static inline int page_kills_ppro(unsign
 #ifdef CONFIG_HIGHMEM
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
 {
-	if (!page_is_ram(pfn)) {
+	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
+		ClearPageReserved(page);
+		set_bit(PG_highmem, &page->flags);
+		set_page_count(page, 1);
+		__free_page(page);
+		totalhigh_pages++;
+	} else
 		SetPageReserved(page);
-		return;
-	}
-	
-	if (bad_ppro && page_kills_ppro(pfn)) {
-		SetPageReserved(page);
-		return;
-	}
-	
-	ClearPageReserved(page);
-	set_bit(PG_highmem, &page->flags);
-	atomic_set(&page->count, 1);
-	__free_page(page);
-	totalhigh_pages++;
 }
 #endif /* CONFIG_HIGHMEM */
 

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
