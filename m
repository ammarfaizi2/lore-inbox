Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTEMWQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTEMWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:16:07 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:60941 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263668AbTEMWNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:13:53 -0400
Date: Tue, 13 May 2003 17:26:24 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <199610000.1052864784@baldur.austin.ibm.com>
In-Reply-To: <3EC15C6D.1040403@kolumbus.fi>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 23:58:21 +0300 Mika Penttilä
<mika.penttila@kolumbus.fi> wrote:

> Isn't that what inode->i_sem is supposed to protect...?

Hmm... Yep, it is.  I did some more investigating.  My initial scenario
required that the task mapping the page extend the file after the truncate,
which must be done via some kind of write().  The write() would trip over
i_sem and therefore hang waiting for vmtruncate() to complete.  So I was
wrong about that one.

Hoever, vmtruncate() does get to truncate_complete_page() with a page
that's mapped...

After some though it occurred to me there is a simple alternative scenario
that's not protected.  If a task is *already* in a page fault mapping the
page in, then vmtruncate() could call zap_page_range() before the page
fault completes.  When the page fault does complete the page will be mapped
into the area previously cleared by vmtruncate().

We could make vmtruncate() take mmap_sem for write, but that seems somewhat
drastic.  Does anyone have any alternative ideas?

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

