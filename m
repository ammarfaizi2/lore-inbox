Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265363AbRFVSCT>; Fri, 22 Jun 2001 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265420AbRFVSCK>; Fri, 22 Jun 2001 14:02:10 -0400
Received: from sncgw.nai.com ([161.69.248.229]:915 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265363AbRFVSB7>;
	Fri, 22 Jun 2001 14:01:59 -0400
Message-ID: <XFMail.20010622110507.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 22 Jun 2001 11:05:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: signal dequeue ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm just trying to figure out the reason why signal must be delivered one at a
time instead of building a frame with multiple calls with only the last one
chaining back to the kernel.
All previous calls instead of calling the stub that jump back to the kernel
will call a small stub like ( Ix86 ) :


stkclean_stub:
        add $frame_size, %esp
        cmp %esp, $end_stubs
        jae $sigreturn_stub
        ret
sigreturn_stub:
        mov __NR_sigreturn, %eax
        int $0x80
end_stubs:

...
| context1
* $stkclean_stub
* sigh1_eip
| context0
* $stkclean_stub
* sigh0_eip


When sigh0 return, it'll call stkclean_stub that will clean context0 and if
we're at the end it'll call the jump-back-to-kernel stub, otherwise the it'll
execute the  ret  the will call sigh1 handler ... and so on.





- Davide

