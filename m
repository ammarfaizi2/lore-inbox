Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUECLhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUECLhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUECLhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:37:50 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:10470 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262101AbUECLhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:37:48 -0400
Message-ID: <40962F75.8000200@cs.auc.dk>
Date: Mon, 03 May 2004 13:39:33 +0200
From: Mikkel Christiansen <mixxel@cs.auc.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: workqueue and pending
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We're trying to use the workqueue interface for scheduling a delayed 
gargage collector.
Since we only need a single delayed thread we used the DECLEARE_WORK macro.

The problem is that once we call cancel_delayed_work we can't schedule 
work again.

Having looked at the code i noticed that cancel_delayed_work only 
deletes the timer but
doesn't set clear the "pending" bit, thus any call to 
schedule_delayed_work is ignorred.

Example:

static DECLARE_WORK(tft, timeoutfun, NULL)
.
.
.
schedule_delayed_work(&tft, 1*HZ);
cancel_delayed_work(&tft);

<do some work>

tft.pending = 0;   / / if we dont clear pending no work can be scheduled
schedule_delayed_work(&tft, 1*HZ);
return 0;

End example

Setting tft.pending is a rather ugly solution - shouldn't it be cleared by
cancel_delayed_work?, or are we using the interface in the wrong way?

Cheers
    Mikkel


