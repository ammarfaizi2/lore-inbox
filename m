Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUKBVCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUKBVCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUKBVCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:02:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59855 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261378AbUKBVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:01:44 -0500
Date: Tue, 2 Nov 2004 21:58:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <4187E920.1070302@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr>
References: <4187E920.1070302@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There's something I've been wondering about for a while.  There is a lot of code
>in linux that looks something like this:
>
>err = -ERRORCODE
>if (error condition)
>	goto out;

That's because there might something as:

err = -EPERM;
if(error) { goto out; }
do something;
if(error2) { goto out; }
do something more;
if(error3) { goto out; }

Is shorter than:

if(error) { err = -EPERM; goto out; }
do something;
if(error2) { err = -EPERM; goto out; }
do something more;
if(error3) { err = -EPERM; goto out; }


>Is there any particular reason why the former is preferred?  Is the compiler

To keep it short. Because it might have been worse than just err =xxx:

if(error) {
    do this and that;
    and more;
    even more;
    more more;
    goto out;
}

Repeating that over and over is not that good. So we wrap it a little bit to do
a "staircase" deinitialization:

err = -EPERM;
if(error) { goto this_didnot_work; }
...
err = -ENOSPC;
if(error) { goto that_didnot_work; }


this_didnot_work:
  all uninitializations needed

that_didnot_work:
  all other uninit's

  return err;


So to summarize, it's done to reduce code whilst keeping the error code around
until we actually leave the function.


My € 0.02!


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
