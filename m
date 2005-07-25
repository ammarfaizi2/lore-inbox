Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVGYTY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVGYTY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGYTY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:24:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65243 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261471AbVGYTYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:24:19 -0400
Subject: Re: xor as a lazy comparison
From: Steven Rostedt <rostedt@goodmis.org>
To: Philippe Troin <phil@fifi.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
In-Reply-To: <87ackaitlj.fsf@ceramic.fifi.org>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com> <1122281833.10780.32.camel@tara.firmix.at>
	 <1122314150.6019.58.camel@localhost.localdomain>
	 <1122318659.1472.14.camel@mindpipe>  <87ackaitlj.fsf@ceramic.fifi.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 25 Jul 2005 15:24:03 -0400
Message-Id: <1122319443.6019.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 12:16 -0700, Philippe Troin wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> > > Doesn't matter. The cycles saved for old compilers is not rational to
> > > have obfuscated code.
> > 
> > Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> > well?
> 
> Depends if you want to multiply by 2 or 4 :-)

I guess this proves my point :-)

But lets look at the signal.c code as well:

        if ((!info || ((unsigned long)info != 1 &&
                        (unsigned long)info != 2 && SI_FROMUSER(info)))
            && ((sig != SIGCONT) ||
                (current->signal->session != t->signal->session))
            && (current->euid ^ t->suid) && (current->euid ^ t->uid)
            && (current->uid ^ t->suid) && (current->uid ^ t->uid)
            && !capable(CAP_KILL))
                return error;

Why did they do the (current->signal->session != t->signal->session) and
not also do (current->signal->session ^ t->signal->session)?

Bit shifting for doubling (or quadrupling) may or may not be confusing,
(I don't mind that), but using xor for non-equal is IMO past that line.
Since, I usually use xor for bit masks. Looking at the above code,
especially since it is not always used, I would think that euid, uid,
and suid are all bitmasks.

-- Steve


