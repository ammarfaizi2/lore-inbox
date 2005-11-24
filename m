Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVKXPcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVKXPcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVKXPcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:32:11 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:62348 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932151AbVKXPcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:32:00 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: dri-devel@lists.sourceforge.net
Subject: Re: 2.6.14-rt4: via DRM errors
Date: Thu, 24 Nov 2005 07:31:55 -0800
User-Agent: KMail/1.8.92
Cc: Thomas =?iso-8859-1?q?Hellstr=F6m?= <unichrome@shipmail.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <1132807985.1921.82.camel@mindpipe> <1132829378.3473.11.camel@mindpipe>  <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
In-Reply-To: <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511240731.56147.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 24, 2005 4:50 am, Thomas Hellström wrote:
> There is some info in the old precision insight documentation about
> the DRI infrastructure, (can't seem to find a link right now) But
> generally there is only one global lock and something called the
> drawable spinlock that is apparently not used anymore. The global
> lock is similar to a futex, with the exception that the kernel is
> called both to resolve contention and whenever a new context is about
> to take the lock, so that optional context switching can take place,
> and also if the client requests that some special action should take
> place after locking is done, like wait for dma ready or quiescent.
> The lock should be taken before writing to the hardware or before
> submitting DMA commands. If you want to be _sure_ that noone else
> uses the hardware (like you want to  read a particular register or
> something), you have to take the lock and wait for DMA quiescent. For
> example, if you want to make sure the video scaler is idle so you can
> write to it, you first take the lock so that noone else writes to it
> or to the DMA queue, then you wait for the DMA queue to be empty or
> make sure there are no pending commands for the scaler, then you wait
> for the scaler to become idle.
>
> The lock value is easily manipulated from user space and resides in
> one of the shared memory areas. I guess this means that with the
> current drm security policy it should be regarded as an advisory lock
> between drm clients.

This is a nice little writeup, maybe it could go into the kernel's 
Documentation/ directory?  It would be nice to document how the lock 
and signal handling interact as well.

> At one point I was about to implement a scheme for via with a number
> of similar locks, one for each independent function on the video
> chip, Like 2D, 3D, Mpeg decoder, Video scaler 1 and 2, so that they
> didn't have to wait for  eachother. The global lock would then only
> be taken to make sure that no drawables were touched by the X server
> or other clients while the lock was held, which would be compatible
> with how the X server works today. Never got around to do that,
> however, but the mpeg decoders have a futex scheme to prevent clients
> stepping on eachother. With that it is possible to have multiple
> clients use the same hw decoder.

Sounds interesting, but that would be card specific, right?  I mean, on 
some cards the 2d and 3d locks would have to be the same because of 
shared state or whatever, for example.

Jesse
