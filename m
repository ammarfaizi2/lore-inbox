Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRA3PKR>; Tue, 30 Jan 2001 10:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129902AbRA3PJz>; Tue, 30 Jan 2001 10:09:55 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:15749 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129962AbRA3PJs>; Tue, 30 Jan 2001 10:09:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A75A70C.4050205@redhat.com> 
In-Reply-To: <3A75A70C.4050205@redhat.com>  <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> 
To: Joe deBlaquiere <jadb@redhat.com>
Cc: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Tue, 30 Jan 2001 15:08:00 +0000
Message-ID: <30672.980867280@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jadb@redhat.com said:
> (If you're running a program XIP from flash and a  RT interrupt leaves
> the flash in a unreadable state, boom!).

Bad example. I don't expect Linux to support writable XIP any time in the 
near future. The only thing I envisage myself doing to help people who want 
writable XIP is to take away their crackpipe.

Until we get dual-port flash, of course.

The thing that really does concern me about the flash driver code is the
fact that it often wants to wait for about 100µs. On machines with
HZ==100, that sucks if you use udelay() and it sucks if you schedule(). So
we end up dropping the spinlock (so at least bottom halves can run again)
and calling:

static inline void cfi_udelay(int us)
{
        if (current->need_resched)
                schedule();
        else
                udelay(us);
}


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
