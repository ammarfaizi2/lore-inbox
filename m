Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRABJpb>; Tue, 2 Jan 2001 04:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRABJpL>; Tue, 2 Jan 2001 04:45:11 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:64527 "HELO
	smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130193AbRABJpJ>; Tue, 2 Jan 2001 04:45:09 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A519108.23A41385@yahoo.com>
Date: Tue, 02 Jan 2001 03:27:52 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Taco IJsselmuiden <taco@wep.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: ne2000 (ISA) & test11+
In-Reply-To: <Pine.LNX.4.21.0101020157290.637-100000@hewpac.taco.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taco IJsselmuiden wrote:
> 
> Second: I'm having problems loading my ne2000 (ISA) card as a module since
> test11 (test10 + 2.2.17 works perfectly. Haven't tried 2.2.18...):
> 
> When loading the module with 'modprobe ne io=0x360 irq=4' it says:
> 
> /lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o: init_module: No
> such device or address
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> 
> When using test10 or 2.2.17 it works ;)
> I'm I just being plain stupid (as in: did I miss something...), or is
> something wrong ??

Ok, I suspect the phasing out of check_region(...) is responsible
here.  In test10 and older, check_region() wasn't done if an explicit
i/o address was supplied - this was to accomodate the now rarely used
reserve= bootprompt which dates back to before modules existed.

Since ne.c doesn't allow modular autoprobing, there was always an i/o
address present, and hence you could still load the module even if
there was a potential i/o space conflict.

In test11 and newer, check_region() is gone and an unconditional
request_region() takes place, which will not allow any i/o space
conflict.  In your case, 0x360 is suspect since a ne2000 is 0x20
wide in i/o space and you are probably bumping into either:

0376-0376 : ide1
0378-037a : parport0

Check your /proc/ioports, and relocate your ne card as appropriate.

Paul.



__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
