Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbRGQWAH>; Tue, 17 Jul 2001 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbRGQV76>; Tue, 17 Jul 2001 17:59:58 -0400
Received: from eagle.datafocus.com ([204.255.0.2]:41182 "EHLO
	hercules.fairfax.datafocus.com") by vger.kernel.org with ESMTP
	id <S267447AbRGQV7x>; Tue, 17 Jul 2001 17:59:53 -0400
Message-ID: <004e01c10f0b$7ed500b0$4d0310ac@fairfax.mkssoftware.com>
From: "Eric Youngdale" <eric@andante.org>
To: "MEHTA,HIREN \(A-SanJose,ex1\)" <hiren_mehta@agilent.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AED@xsj02.sjs.agilent.com>
Subject: Re: who decrements can_queue in Scsi_Host structure ?
Date: Tue, 17 Jul 2001 17:57:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     /*
>      * THis determines if we will use a non-interrupt driven
>      * or an interrupt driver scheme, It is set to the maximum number
>      * of simultaneous commands a given host adapter will accept.
>      */
>     int can_queue;
>
> Scsi_Host structure also has the same variable which gets initialized
> with the can_queue of SHT structure in the scsi_register().
> Let's say the can_queue in initialized to 16. Now, I could not find
> anybody decrementing this variable. So, when the time comes to
> send a new command to the hba, the can_queue of the host sturcture is
> checked and if that is non-zero, then the queuecommand() entry point
> is immediately called. So, the queuecommand will always be called
> even if the host is already given 'can_queue' commands.
>
> Any inputs on this ?

    It should never be decremented or incremented - this one should remain
relatively static.  The host_busy field indicates the number of commands
currently running on the HBA.

    I am seeing a bug however - in the event that can_queue is 0, the theory
was that we would go ahead and send the command down anyways and if the HBA
driver was busy it would simply reject it.  Instead we are falling through
into the ->command interface, which isn't at all what we want.

-Eric


-Eric


