Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279370AbRKARCy>; Thu, 1 Nov 2001 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279337AbRKARCp>; Thu, 1 Nov 2001 12:02:45 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48957 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279370AbRKARCg>; Thu, 1 Nov 2001 12:02:36 -0500
Date: Thu, 1 Nov 2001 12:02:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011101120222.B11773@redhat.com>
In-Reply-To: <01110116355201.01137@nemo> <Pine.LNX.3.95.1011101102602.30559A-101000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1011101102602.30559A-101000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Nov 01, 2001 at 10:34:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 10:34:53AM -0500, Richard B. Johnson wrote:
> Well not exactly zealots. I test a lot of stuff. In fact, the code
> you propose:
> 
> 	if(++jiffies==0) jiffies_hi++;
> 
> ... actually works quite well:

Uhm, no, it really doesn't.  See how it pairs with other instructions and 
what the cost is when it doesn't have to be as bad:

this:
	unsigned long a, b;
	if (++a == 0) b++;
gives:
        movl    a, %eax
        movl    %esp, %ebp
        incl    %eax
        testl   %eax, %eax
        movl    %eax, a
        je      .L3
.L2:
        popl    %ebp
        ret
        .p2align 4,,7
.L3:
        incl    b
        jmp     .L2

which is really gross considering that:

	unsigned long long c;
	c++;

gives:

        addl    $1, c
        adcl    $0, c+4

which is quite excellent.

		-ben
