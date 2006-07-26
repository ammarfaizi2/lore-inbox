Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWGZNT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWGZNT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWGZNT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:19:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:51270 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751114AbWGZNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:19:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R/bb8sQk9wFjiNlRz6t4/yeZOh/ubxfVVUn2GDKJ8GPeg6lGZwXyE5pN0vmNPI0ZxxGQj+0eoMKGGok+zrpXDft2DWh/RtN8DIt1ga5VVLrov+/HRONpEQ4LKEKwnwUVBiG8fMlxR3Q30dP980saKHvcarRsZ9Qc6oORX3aOEKU=
Message-ID: <d120d5000607260619j6019d0ffh59fca33032cb5b6e@mail.gmail.com>
Date: Wed, 26 Jul 2006 09:19:24 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 1/2] OMAP: Add keypad driver
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, tony@atomide.com,
       ext-timo.teras@nokia.com, r-woodruff2@ti.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net, kjh@hilman.org
In-Reply-To: <1153915433.13733.266905718@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153915433.13733.266905718@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> Andrew/Tony/Richard/Dmitry,
>
> This is a revised patch as per the review comments from the Dmitry
> on thread:
>
> http://lkml.org/lkml/2006/7/25/279
>
> Please review it and give me the Ack if looks ok.
>

Komal,

You may not call input_free_device() after calling
input_unregister_device() in the error path because unregister will
drop the reference to the device and since it was the last (and only)
reference it will free the device. input_free_device() coming after
that will try to free already freed memory.

You have several options:
1. Have separate error paths for before and after input_register_device()
2. Set input_dev = NULL after calling input_unregister_device() -
input-free-device() handles NULLs just fine.
3. Take an extra reference with input_get_device() before calling
input_unregister_device(). This way the device won't actually be freed
until you call input_free_device() later.

-- 
Dmitry
