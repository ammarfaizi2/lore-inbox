Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317787AbSGZOAW>; Fri, 26 Jul 2002 10:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317789AbSGZOAW>; Fri, 26 Jul 2002 10:00:22 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54513 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317787AbSGZOAV>; Fri, 26 Jul 2002 10:00:21 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027695029.13428.45.camel@irongate.swansea.linux.org.uk> 
References: <1027695029.13428.45.camel@irongate.swansea.linux.org.uk>  <1027680964.13428.37.camel@irongate.swansea.linux.org.uk> <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> <12015.1027676388@redhat.com> <12441.1027677534@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 15:03:25 +0100
Message-ID: <26333.1027692205@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Anything where you rely on locking the pages and can get a loop of
> locked/absent pages and deadlock

Good point -- so if a writer encounters a locked page when it's trying to 
unmap them all, it needs to still allow other pages to be mapped in while 
it waits for the original page to become unlocked. That avoids the deadlock 
-- but leaves us with the potential for livelock, with the writer being 
starved by too many other things locking down the pages in question.

I suspect the number of pages getting locked will be sufficiently small 
that the deadlock does not occur. 

In what circumstances will such mmapped pages get locked?

The case of O_DIRECT or rawio writes to flash is easily avoided -- just 
don't allow raw or O_DIRECT writes to flash from _anywhere_ while XIP is in 
use. O_DIRECT and rawio to other destinations is fine. What else? Assume 
we don't permit mlock() :)

--
dwmw2


