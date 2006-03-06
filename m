Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752057AbWCGADZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbWCGADZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWCGADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:03:25 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:48029 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1752057AbWCGADY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:03:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=E7tUycs3Z9nWLWMksH6g7tBf8jHy+1x038YgvA8l/0+qHggG3VYpkh91jQ7CYaaLc2VLRVzqyEb2xlZ2X/C2fkyVKwthF9n10rGp9og34GI9g64t+nEyEaZpduNlKhEQqvChMHiZlduDJ7lP3l5dwarhXezx+VTWXFR1WEGAwAM=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <6D8D14D2-4ED3-46ED-8FB9-FF8567DC9F70@mac.com>
References: <1141358816.3582.18.camel@Rainsong.home>
	 <1141359278.3582.22.camel@Rainsong.home>
	 <20060302233249.2aa918f4.mrmacman_g4@mac.com>
	 <1141421511.11092.66.camel@Rainsong.home>
	 <6D8D14D2-4ED3-46ED-8FB9-FF8567DC9F70@mac.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 18:59:14 -0500
Message-Id: <1141689554.19207.35.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me - sent half a response earlier.

On Sat, 2006-04-03 at 17:57 -0500, Kyle Moffett wrote:
> On Mar 3, 2006, at 16:31:51, James C. Georgas wrote:
> > On Thu, 2006-02-03 at 23:32 -0500, Kyle Moffett wrote:
> >> af_unix (IE: CONFIG_UNIX) currently uses the symbol  
> >> get_max_files.  It is the only module that uses that symbol, and  
> >> that symbol probably should not be exported as it's kind of an  
> >> internal API.  Therefore if we mandate that CONFIG_UNIX != m, then  
> >> that symbol may be properly unexported and made private, because  
> >> nothing modular would use it.  Does that clear things up?
> >
> > Yes, I think I understand.
> >
> > However, even if you don't export the symbol, I don't see how you  
> > can make it private (i.e. static declaration) to file_table.c,  
> > since it has to remain extern, in order to be visible to af_unix.c.
> 
> You're missing some crucial information about how Linux operates.   
> EXPORT_SYMBOL != extern.  Basically, Linux maintains a list of  
> symbols that dynamically loaded modules are allowed to use, along  
> with some technical usage restrictions on each  (Symbols exported  
> with EXPORT_SYMBOL_GPL may only be used by modules that declare  
> 'MODULE_LICENSE("GPL");'.)  Exporting a symbol increases the  
> likliehood that some module author will use it inappropriately, and  
> bloats the kernel.  In this case, removing the EXPORT_SYMBOL() would  
> be a good thing.


Isn't it kind of pointless to not EXPORT a symbol if the symbol is still
declared globally in an include/linux/ header file? If the intent is to
prevent abuse of the symbol, then this doesn't do it, because I can just
statically compile my module into the kernel, and keep on using that
symbol.

It makes sense to me to remove the EXPORT of get_max_files only if the
intent is to eventually remove the get_max_files function from
include/linux/fs.h.

This would require that af_unix.c calculate the maximum number of
allowed open Unix sockets from information other than the
files_stat.max_files value is fs/file_table.c.

If that's the intent, then there's no point in disallowing AF_UNIX=m.
Doing this just so one can unEXPORT a symbol only fixes half the issue.

> Cheers,
> Kyle Moffett
> 
-- 
James C. Georgas <jgeorgas@rogers.com>

