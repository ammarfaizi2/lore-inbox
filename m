Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVC2IOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVC2IOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVC2INx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:13:53 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8581 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262562AbVC2HYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:24:08 -0500
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
            <1111825958.6293.28.camel@laptopd505.fenrus.org>
            <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
            <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
            <1111881955.957.11.camel@mindpipe>
            <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
            <20050327065655.6474d5d6.pj@engr.sgi.com>
            <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
            <20050327174026.GA708@redhat.com>
            <1112064777.19014.17.camel@mindpipe>
            <84144f02050328223017b17746@mail.gmail.com>
            <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pekka Enberg <penberg@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
Date: Tue, 29 Mar 2005 10:24:03 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42490293.000032B0@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Jan Engelhardt writes:
> "[...]In general, you should prefer to use actual profile feedback for this 
> (`-fprofile-arcs'), as programmers are NOTORIOUSLY BAD AT PREDICTING how 
> their programs actually perform." --gcc info pages.

Indeed. 

I wrote:
> > The optimization does not help if you are releasing actual memory.

Jan Engelhardt writes:
> It does not turn the real case (releasing memory) worse, but just improves the 
> unreal case (releasing NULL).

You don't know that until you profile! Please note that it _can_ turn the 
real case worse as the generated code will be bigger (assuming we inline 
kfree() to optimize the special case). To summarize: 

 (1) The optimization only helps when the passed pointer is NULL.
 (2) Most of the time, kfree() _should_ be given a real pointer.
     Anything else but sounds quite broken.
 (3) We don't know if inlining kfree() hurts the common case.
 (4) The cleanups Jesper and others are doing are to remove the
     _redundant_ NULL checks (i.e. it is now checked twice). 

Therefore please keep merging the cleanup patches and don't inline kfree() 
unless someone can show a _globally visible_ performance regression (i.e. p% 
slowdown in XYZ benchmark). 

               Pekka 

