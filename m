Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbQLHS4F>; Fri, 8 Dec 2000 13:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130146AbQLHSz4>; Fri, 8 Dec 2000 13:55:56 -0500
Received: from feral.com ([192.67.166.1]:19784 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S130038AbQLHSzs>;
	Fri, 8 Dec 2000 13:55:48 -0500
Date: Fri, 8 Dec 2000 10:22:22 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: baettig@scs.ch, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
In-Reply-To: <E144NpK-0003ti-00@the-village.bc.nu>
Message-ID: <Pine.BSF.4.21.0012081017560.29052-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > 	spin_lock_irq(&io_request_lock);
> > we finish the request and return to the add_request function which calls
> > 	spin_unlock_irqrestore(&io_request_lock,flags);
> > and restores the flags.     
> > 
> > Isn't it possible now that the flags which we restore are out of date now?
> > Is this idiom the right one to use for 2.2?
> 
> It is fine for 2.2 as well.
> 
> The flags you restore are ok. It restores the interrupt state to the state it
> was in when you were called. Think of save_flags/restore_flags as bracketing
> regions of code (and being nestable in pairs). The only real bizarre rule is
> that you cannot save_flags in one function and restore_flags in another without
> upsetting DaveM - as it breaks on the sparc if you do that

Yes, and I believe that this is what's broken about the SCSI midlayer. The the
io_request_lock cannot be completely released in a SCSI HBA because the flags
for that save are way up the stack somewhere. This means that if you need to,
for example, sleep on something like loop coming up, you can spin_unlock_irq,
but you can't restore flags, so for the UP case, you just hang. To avoid this,
I'm having to build a kernel thread to handle all of this kind of stuff in a
separate context. What a PITA.

-matt



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
