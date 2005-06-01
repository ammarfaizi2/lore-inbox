Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVFAGsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVFAGsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFAGsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:48:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3023 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261299AbVFAGr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:47:27 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@muc.de>
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Date: Wed, 1 Jun 2005 09:47:08 +0300
User-Agent: KMail/1.5.4
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20050530181626.GA10212@kvack.org> <20050531135959.GA16081@kvack.org> <200506010922.48521.vda@ilport.com.ua>
In-Reply-To: <200506010922.48521.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_snVnCbL/JbAeP7v"
Message-Id: <200506010947.08010.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_snVnCbL/JbAeP7v
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 01 June 2005 09:22, Denis Vlasenko wrote:
> On Tuesday 31 May 2005 16:59, Benjamin LaHaise wrote:
> > On Tue, May 31, 2005 at 11:23:58AM +0200, Andi Kleen wrote:
> > > fork is only a corner case. The main case is a process allocating
> > > memory using brk/mmap and then using it.
> 
> I did the tests. I confirm Andi's conclusion that
> if you are going to use cleared/copied page immediately,
> nt stores are a loss.

For anyone interested, here are the results and tarball with patch
which allows to switch routines on the fly, plus test programs/scripts.

You need to apply the patch, compile programs (see testing/mk)
and run (see testing/m).

Zero 1 page (4k), x300000 times:
./zero1 4 300000
method............. times.................. clears/copies
slow:               0m2.094 0m2.143 0m2.143 1800225/332
mmx_APn:            0m1.931 0m2.036 0m2.053 1800207/316
mmx_APN:            0m3.458 0m3.476 0m3.487 1800212/335
mmx_APn/APN:        0m2.023 0m2.057 0m2.225 1800205/297
n - normal stores, N - nt stores, n/N - nt stores for copy only

Zero 100 pages, x3000 times (zero all pages, read back all pages):
./zero1 400 3000
slow:               0m2.861 0m2.865 0m2.958 909218/323
mmx_APn:            0m2.626 0m2.715 0m2.783 909208/307
mmx_APN:            0m2.240 0m2.249 0m2.251 909212/294
mmx_APn/APN:        0m2.715 0m2.752 0m2.761 909220/324

Zero 100 pages, x3000 times (zero page, read back page, repeat for all pages):
./zero2 400 3000
slow:               0m1.711 0m1.734 0m1.739 909211/306
mmx_APn:            0m1.548 0m1.585 0m1.616 909208/303
mmx_APN:            0m2.088 0m2.102 0m2.104 909203/287
mmx_APn/APN:        0m1.589 0m1.603 0m1.617 909202/288

Andi is right. If we read pages back immediately, we lose.
If we defer that, we win.

Fork and copy 1 page, x150000 times
./copy1 4 150000
slow:               0m4.464 0m4.487 0m4.495 1350240/900353
mmx_APn:            0m3.979 0m4.090 0m4.191 1350229/900327
mmx_APN:            0m5.685 0m5.722 0m5.744 1350229/900348
mmx_APn/APN:        0m4.730 0m4.826 0m4.975 1350221/900340

Fork and copy 100 pages, x1500 times (copy all pages, read back all copied pages):
./copy1 400 1500
slow:               0m2.561 0m2.568 0m2.576 14019/454824
mmx_APn:            0m2.230 0m2.237 0m2.242 14011/454804
mmx_APN:            0m1.841 0m1.865 0m1.876 14008/454791
mmx_APn/APN:        0m1.906 0m1.909 0m1.922 14010/454788

Fork and copy 100 pages, x1500 times (copy page, read back copied page, repeat for each page):
./copy2 400 1500
slow:               0m2.097 0m2.107 0m2.121 14020/454821
mmx_APn:            0m1.769 0m1.776 0m1.788 14008/454787
mmx_APN:            0m1.975 0m1.978 0m2.015 14035/454791
mmx_APn/APN:        0m1.979 0m2.009 0m2.017 14013/454810
--
vda

--Boundary-00=_snVnCbL/JbAeP7v
Content-Type: application/x-tbz;
  name="t.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="t.tar.bz2"

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

--Boundary-00=_snVnCbL/JbAeP7v--

