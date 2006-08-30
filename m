Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWH3Rxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWH3Rxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWH3Rxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:53:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:49008 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751265AbWH3Rxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:53:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=f0f/pnVyOoBBTgTn6htqQu/YMxHr8F5cJmTTyBGzVme0j0gYsnqW1KHnBLDIdnEv1psQ2jVRk1YVgblXgC/188WWbqBrr7JVMEW2zoJM8qo9199amkUQgCRe5Ip8AJyKI9TF7s4+GiXgE4x+xkLpAHbjxpfhDkiuVP3upYvHNcs=
Date: Wed, 30 Aug 2006 20:51:36 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
Message-ID: <20060830205136.4f9bfd33@localhost>
In-Reply-To: <200608301931.14434.ak@suse.de>
References: <44F1F356.5030105@zytor.com>
	<200608301856.11125.ak@suse.de>
	<20060830200638.504602e2@localhost>
	<200608301931.14434.ak@suse.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 19:31:14 +0200
Andi Kleen <ak@suse.de> wrote:

> On Wednesday 30 August 2006 19:06, Alon Bar-Lev wrote:
> 
> > > 
> > > And the other thing is that this will cost memory. Either make
> > > it dependend on !CONFIG_SMALL or fix the boot code to save the 
> > > command line into a kmalloc'ed buffer of the right size and
> > > __init the original one
> > 
> > I don't mind doing either... Any preference for one of them? The
> > kmalloc approach seems nicer..
> 
> kmalloc is better yes. You just have to do it after kmalloc is up
> and running and make sure the users before reference the __init'ed
> version. I suspect only /proc/cmdline will need the kmalloc version
> after booting, nobody else should look at the command line.
> 
> -Andi

This is not entirely true...
All architectures sets saved_command_line variable...
So I can add __init to the saved_command_line and
copy its contents into kmalloced persistence_command_line at
main.c.

Then the following files should be modified to use the new kmalloced variable:

./drivers/sbus/char/openprom.c: char *buf = saved_command_line;
./fs/proc/kcore.c:      strncpy(prpsinfo.pr_psargs, saved_command_line, ELF_PRARGSZ);
./fs/proc/proc_misc.c:  len = sprintf(page, "%s\n", saved_command_line);

Have I got it right?

Best Regards,
Alon Bar-Lev.
