Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUHTXan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUHTXan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUHTXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:30:43 -0400
Received: from hermes.domdv.de ([193.102.202.1]:26888 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S268709AbUHTXai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:30:38 -0400
Message-ID: <41268994.9070900@domdv.de>
Date: Sat, 21 Aug 2004 01:30:28 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040715
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       fsteiner-mail@bio.ifi.lmu.de, kernel@wildsau.enemy.org,
       diablod3@gmail.com, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain> <200408191800.56581.bzolnier@elka.pw.edu.pl> <4124D042.nail85A1E3BQ6@burner> <1092938348.28370.19.camel@localhost.localdomain> <4125FFA2.nail8LD61HFT4@burner> <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
In-Reply-To: <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> Chosen solution for 2.6.8.1:
>     Only allow certain known-safe commands, anything else needs
> root privileges, specifically CAP_SYS_RAWIO or CAP_SYS_ADMIN,
>  (Seems sane, and follows with the general design of the  rest of the
> kernel).

To make this clear first: I don't want to step on anyone's toes.

So here is a snippet of code that should work nicely on 2.4 and 2.6 (the 
latter with the sanitized kernel headers) to set the required 
capabiltities in a setuid() wrapper:

#include <unistd.h>
#include <linux/capability.h>
#include <sys/prctl.h>
extern int capset(cap_user_header_t header, const cap_user_data_t data);

int do_setuid(uid_t uid)
{
   int r;
   struct __user_cap_header_struct h;
   struct __user_cap_data_struct c;

   if(geteuid())return setuid(uid);
   memset(&h,0,sizeof(h));
   h.version=_LINUX_CAPABILITY_VERSION;
   h.pid=0;
   memset(&c,0,sizeof(c));
   c.effective=1<<CAP_SYS_RAWIO|1<<CAP_SYS_ADMIN|1<<CAP_SETUID;
   c.permitted=1<<CAP_SYS_RAWIO|1<<CAP_SYS_ADMIN|1<<CAP_SETUID;
   c.inheritable=0;
   capset(&h,&c);
   prctl(PR_SET_KEEPCAPS,1,0,0,0);
   r=setuid(uid);
   memset(&h,0,sizeof(h));
   h.version=_LINUX_CAPABILITY_VERSION;
   h.pid=0;
   memset(&c,0,sizeof(c));
   c.effective=1<<CAP_SYS_RAWIO|1<<CAP_SYS_ADMIN;
   c.permitted=1<<CAP_SYS_RAWIO|1<<CAP_SYS_ADMIN;
   c.inheritable=0;
   capset(&h,&c);
   prctl(PR_SET_KEEPCAPS,0,0,0,0);
   return r;
}

Now this is what free software is all about. Reuse of knowledge for 
everyone. Jörg, feel free to use the above code. Note that the 
CAP_SETUID usage is a workaround for a 2.4 bug.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
