Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVISEL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVISEL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVISEL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:11:59 -0400
Received: from smtp.enter.net ([216.193.128.24]:57862 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932168AbVISEL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:11:59 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Patch] Support UTF-8 scripts
Date: Mon, 19 Sep 2005 00:14:52 +0000
User-Agent: KMail/1.7.2
Cc: "Martin v. =?iso-8859-1?q?L=F6wis?=" <martin@v.loewis.de>, 7eggert@gmx.de,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <4N6EL-4Hq-3@gated-at.bofh.it> <200509172231.33872.dhazelton@enter.net> <3FEE1455-90E8-4855-9BA4-045A6EE5D82B@mac.com>
In-Reply-To: <3FEE1455-90E8-4855-9BA4-045A6EE5D82B@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509190014.52868.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 September 2005 03:45, Kyle Moffett wrote:
> On Sep 17, 2005, at 18:31:33, D. Hazelton wrote:
> > That, and my point remains that the kernel should know absolutely
> > nothing about how to execute a text file - the kernel should
> > return an error to the extent of "I don't know what to do with
> > this file" to the shell that tries to execute it, and the shell
> > can then check for the sh_bang. I do admit that this change would
> > break a lot of existing code, so I'll leave the argument to the
> > experts.
>
> No, that would not work at all.  We have a very nice system to
> allow set-uid scripts (Specifically, I like my nice secure
> taint-mode set- uid perl scripts).  If you did this, they would
> break completely, not to mention _add_ all sorts of unsolvable race
> conditions to the few ways of working around such a lack of SUID
> scripts.  Also, it means that I can't just "mv /sbin/init
> /sbin/init.real ; vim /sbin/init" to do a simple wrapper around the
> init program, I would need to write a compiled C program to do all
> sorts of fragile hackish things like calling a script
> /sbin/init.sh.

This makes a lot more sense than I expected to hear. This argument 
alone is enough for me to understand the reasoning behind the kernel 
knowing how to interpret a shell script. Problem is, the program 
would not be fragile or hackish - it'd be almost as simple as a 
"hello world" program.

#include <unistd.h>

int main() {
  /* if this fails the system is busted anyway */
  return execve( "/bin/sh", "/sbin/init.sh", 0 );
};

-- This program would do the trick nicely, and since init is run as 
root, there is no need to worry about the program having to grab 
privs. 

However, the real problem is that this would break the initrd systems 
used by most distributions for installation, and it would probably 
break most of the "early userspace" systems just coming into use. As 
I said originally - my  comment about having the shell itself 
interpret the sh_bang would break a lot of stuff and I've been shown 
that I have to spend more time in the kernel code (as I haven't 
finished going through the various drivers to see how those have been 
made to work) before I can make a good suggestion in a discussion 
like this.

DRH
