Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031403AbWLAN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031403AbWLAN70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936507AbWLAN70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:59:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:63898 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936505AbWLAN7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:59:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=HalJLzFq/QCcUX8A/idL9t4guBZFqe8UHfZgf73b/jg0L/R5BFulM1zL4MoJSRSbub9ovT8RsHqHzfTyesVIykDCZQlyYIg79+iy9fbI/5MGFhwezfICjuIvZY6PZeglE/X9YHSFrge1QFavHgHcmcpCSb6RsK5HReNuYqlggcw=
Message-ID: <4570352B.9000704@gmail.com>
Date: Fri, 01 Dec 2006 22:59:07 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Berck E. Nash" <flyboy@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com> <456FD4CB.8020608@gmail.com> <45702F9A.5020406@gmail.com>
In-Reply-To: <45702F9A.5020406@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berck E. Nash wrote:
> Hrm.  It's not a Silicon Image chip, or at least doesn't claim to be:

Yeap, the controller is ich ahci but I'm pretty sure there's a PMP chip
connected to one of them.  Look for 4723 in the following page.

http://www.asus.com/products4.aspx?modelmenu=2&model=1198&l1=3&l2=11&l3=248

> 00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family)
> Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 2606
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 316
>         Region 0: I/O ports at e400 [size=8]
>         Region 1: I/O ports at e080 [size=4]
>         Region 2: I/O ports at e000 [size=8]
>         Region 3: I/O ports at dc00 [size=4]
>         Region 4: I/O ports at d880 [size=16]
>         Region 5: Memory at febfb800 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 Enable+
>                 Address: fee0300c  Data: 4179
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> And, remember, this behavior started in 2.6.18 and didn't exist in
> 2.6.17.  Would it help if I narrowed down which patch caused it?

Yeah, that's probably because we're now using IRQ-driven PIO for
IDENTIFY, so we're often slower at detecting IDENTIFY failure.  We're
planning to go back to polling IDENTIFY.  Anyways, the problem here is
that the 4723 is emulating ATA device for configuration but it isn't
doing it quite right.  I'll ask SIMG about it.

-- 
tejun
