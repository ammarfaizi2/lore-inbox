Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWGKQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGKQuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGKQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:50:04 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:36185 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751111AbWGKQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:50:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5XvLVzxrYfk+k+FyrMAVdBF4q3ljSPmT5WgKS93B4WBlu842hNIu6lSHby9LLZ7OrB0hv2MpOOqakgbzZEV9kFGvlI1mvx3Zfkj7svwWPgatVbCVb7r1FXXVhJoLgJGrF0iNEe5zuuE2S04vJV8dSlM5/+6QG6D8IoEZRlrMwso=  ;
Message-ID: <44B382DD.5070202@yahoo.com.au>
Date: Tue, 11 Jul 2006 20:52:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, efault@gmx.de
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info
 unavailable
References: <200607101034_MC3-1-C497-51F7@compuserve.com> <20060711012755.59965932.akpm@osdl.org>
In-Reply-To: <20060711012755.59965932.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I think we can do it a lot more tidily.
> 
> static void handle_BUG(struct pt_regs *regs)
> {
> 	unsigned long eip = regs->eip;
> 	unsigned short ud2;
> 
> 	if (eip < PAGE_OFFSET)
> 		return;
> 	if (__get_user(ud2, (unsigned short __user *)eip))
> 		return;
> 	if (ud2 != 0x0b0f)
> 		return;
> 
> 	printk(KERN_EMERG "------------[ cut here ]------------\n");
> 
> #ifdef CONFIG_DEBUG_BUGVERBOSE
> 	do {
> 		unsigned short line;
> 		char *file;
> 		char c;
> 
> 		if (__get_user(line, (unsigned short __user *)(eip + 2)))
> 			break;
> 		if (__get_user(file, (char * __user *)(eip + 4)) ||
> 		    (unsigned long)file < PAGE_OFFSET || __get_user(c, file))
> 			file = "<bad filename>";
> 
> 		printk(KERN_EMERG "kernel BUG at %s:%d!\n", file, line);
> 		return;
> 	} while (0);
> #endif
> 	printk(KERN_EMERG "Kernel BUG at [verbose debug info unavailable]\n");
> }
> 
> 
> OK?

OK but you don't need a do/while(0) here.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
