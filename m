Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUFZXVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUFZXVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUFZXVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:21:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266492AbUFZXVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:21:16 -0400
Date: Sat, 26 Jun 2004 16:20:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040626162020.67d661c7.davem@redhat.com>
In-Reply-To: <200406270036.14716.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406262356.49275.oliver@neukum.org>
	<20040626150700.544a4fb4.davem@redhat.com>
	<200406270036.14716.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 00:36:14 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> So either it has no effect or it is needed?
> Then why take the risk that gcc is changed or an architecture added that
> needs it? It seems to be cleaner to me to mark data structures that
> must be layed out as specified specially. Safer, too, just in case.

Because it generates enormously inefficient code on RISC
platforms.  It turns simple word loads like:

	ld	[%addr], %reg

into something like:

	ldub	[%addr + 0], %tmp1
	ldub	[%addr + 1], %tmp2
	ldub	[%addr + 2], %tmp3
	ldub	[%addr + 3], %tmp4
	sll	%tmp1, 24, %tmp1
	sll	%tmp2, 16, %tmp2
	sll	%tmp3, 8, %tmp3
	or	%tmp1, %tmp2, %tmp1
	or	%tmp1, %tmp3, %tmp1
	or	%tmp1, %tmp4, %reg

A ten-fold increase in code size just to access any member
of the structure.

I think you have no idea how astronomically inefficient the code is
which gets generated when you add the packed attribute to a structure.
