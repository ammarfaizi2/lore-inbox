Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135721AbREFPps>; Sun, 6 May 2001 11:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbREFPph>; Sun, 6 May 2001 11:45:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:48111 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135721AbREFPpY>; Sun, 6 May 2001 11:45:24 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010506142548.D31269@metastasis.f00f.org> 
In-Reply-To: <20010506142548.D31269@metastasis.f00f.org>  <20010506033746.A30690@metastasis.f00f.org> <Pine.LNX.4.21.0105052317080.582-100000@imladris.rielhome.conectiva> 
To: Chris Wedgwood <cw@f00f.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Peter Rival <frival@zk3.dec.com>,
        Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 May 2001 16:38:18 +0100
Message-ID: <12862.989163498@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cw@f00f.org said:
>  How do you relocate
>   -- pages which are mlocked without violating RT contraints?
>   -- pages which contain kernel pointers and might be accessed from
>      interrupt context? 

Those two are the same problem, essentially. You have to copy the page, 
then map it into the same virtual address (be that userspace or 
kernelspace) as the old one. Mark the page readonly when you start to copy 
it, and have a fault handler which immediately marks it writable and 
returns. If the source is writable by the time you've finished the copy, 
repeat.

If you have to repeat yourself more than $n times, you're probably 
experiencing livelock. At that point, do what Rik said - to hell with the 
RT constraints, disable interrupts and do the copy. At least your cache is 
warm :)

--
dwmw2


