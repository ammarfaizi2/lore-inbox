Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCIUpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUCIUpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:45:33 -0500
Received: from smtp.nildram.co.uk ([195.112.4.54]:13065 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S262050AbUCIUpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:45:21 -0500
Subject: Question on bind/connect/send in net/ipv4/udp.c in 2.4.25,
	possible bug in udp.c
From: Anton Ivanov <arivanov@sigsegv.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078865119.18912.32.camel@gondor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 20:45:20 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

        First, sorry for the rather long post.

Background:

        I have been investigating some problems with tftpd-hpa. It does
not operate correctly on some multihomed machines and is sending from an
address different to the one it was told to bind. It uses the rather
uncommon for udp approach of bind(), connect(), send() instead of bind()
followed by simple sendto().

        After going through the tftpd code, glibc and the kernel and
discussing it with hpa@zytor.com himself I am think that the reason for
the behaviour of sending from an address different from the bound one
comes from the udp.c in the kernel ipv4. 

        The entire thing is filed with debian bug ID 234728

Problem (line numbers as of net/ipv4/udp.c in 2.4.25):

        If a udp socket is in a connected state on lines 533,534 it does
a sk_dst_check. As a side effect rt->rt_src is set. This is used after
that to fill the src of the udp packet and the bind is effectively
ignored as far as the ip address is concerned. 

        This is not the case for unconnected sockets which operate
correctly because they have the rt->rt_src filled with a correct value
around line 537.

Question:

        Should a connect udp socket honour bind() in first place?

        If it should current code does not seem quite right. I think  it
needs making the assignment of 

        ufh.saddr = rt->rt_src;

at line 552 conditional on ufh.saddr.

        Sorry for not suggesting a patch, but I have not looked at the
kernel internal for a while now and I do not think that I 100%
understand all cases where ufh.saddr is being filled by something
meaningful prior to that line so I'd rather ask first :-)

        Brgds,

A.

P.S. 
        I am not currently subscribed to the list. I would appreciate if
you cc me on any replies. 

Brgds,

A.

