Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbRLJSRT>; Mon, 10 Dec 2001 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286340AbRLJSRJ>; Mon, 10 Dec 2001 13:17:09 -0500
Received: from cs182024.pp.htv.fi ([213.243.182.24]:6272 "EHLO
	cs182024.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S286339AbRLJSQx>; Mon, 10 Dec 2001 13:16:53 -0500
Message-ID: <3C14FBE7.E3A5F745@welho.com>
Date: Mon, 10 Dec 2001 20:16:07 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru, davem@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: TCP LAST-ACK state broken in 2.4.17-pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I came across the following behavior (sorry, no tcpdump but this should
be easy to reproduce with the right tools):

hostA                 hostB
  --------FIN----------->
  <-----data+FIN---------
  --------ACK-------X       (packet lost)
  <-----data+FIN---------   (retransmit)
  <-----data+FIN---------   (retransmit)
  <-----data+FIN---------   (retransmit)
          ....
  <-----data+FIN---------   (retransmit)
  --------RST----------->

HostA is running Linux 2.4.17-pre2. HostB is running Symbian OS. All the
sequence numbers pan out.

Either LAST-ACK is completely broken or Linux just cannot handle a
FIN-ACK that is piggybacked on a data segment, when received in LAST-ACK
state. It should be acked as an out-of-window segment, as usual.
Finally, the LAST-ACK state times out and Linux responds to the FIN
segment with an RST.

Cheers,

	MikaL
