Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUASWf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUASWf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:35:56 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44243 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264535AbUASWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:35:50 -0500
From: Willem Riede <wrlk@riede.org>
Subject: Re: [PATCH] fix for ide-scsi crash
Date: Mon, 19 Jan 2004 17:35:43 -0500
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2004.01.19.22.35.42.365482@riede.org>
References: <UTC200401190435.i0J4Zwp26577.aeb@smtp.cwi.nl>
Reply-To: wrlk@riede.org
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 05:35:58 +0100, Andries.Brouwer wrote:

> -	spin_unlock_irq(cmd->device->host->host_lock);
> -	(void) ide_do_drive_cmd (drive, rq, ide_end);
> -	spin_lock_irq(cmd->device->host->host_lock);
> +	{
> +		struct Scsi_Host *host = cmd->device->host;
> +		spin_unlock_irq(host->host_lock);
> +		(void) ide_do_drive_cmd(drive, rq, ide_end);
> +		spin_lock_irq(host->host_lock);
> +	}

Interesting. So cmd->device->host changed after ide_do_drive_cmd?

That may be a problem if the scsi error handler has to spring 
into action for this command, as it uses that field extensively...

> -	if (pc) kfree (pc);
> -	if (rq) kfree (rq);
> +	kfree (pc);
> +	kfree (rq);

So it is OK to rely on the NULL check in kfree?

Thanks, Willem Riede.

