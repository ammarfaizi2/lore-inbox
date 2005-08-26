Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbVHZWoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbVHZWoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbVHZWoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 18:44:44 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:37065 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751608AbVHZWon convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 18:44:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k+iYPoqKXx1F4tw+QiZZYHfrFXtXIbFCm9+qmpKc3NeTrebNygvi9KjUMWMz9FNYqZKG8bwXYN9dh+IHeyCKPomUKIxzoZSwJ3S/vCUroDU3hKH/JABZAG3/0ln5zKUDpXeO3wB+yZkPUG9OIb85qOY9rwHxT81s7Bn1gTHC3mc=
Message-ID: <d120d50005082615445557d776@mail.gmail.com>
Date: Fri, 26 Aug 2005 17:44:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Love <rml@novell.com>
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125094725.18155.120.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125094725.18155.120.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Robert Love <rml@novell.com> wrote:

> +static void hdaps_calibrate(void)
> +{
> +       int x, y, ret;
> +
> +       ret = accelerometer_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
> +       if (unlikely(ret))
> +               return;
> +
> +       rest_x = x;
> +       rest_y = y;
> +}

Is this function used in a hot path to warrant using "unlikely"? There
are to many "unlikely" in the code for my taste.

> +
> +static ssize_t hdaps_mousedev_store(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf, size_t count)
> +{
> +       int enable;
> +
> +       if (sscanf(buf, "%d", &enable) != 1)
> +               return -EINVAL;
> +
> +       spin_lock(&hdaps_lock);
> +       if (enable == 1)
> +               hdaps_mousedev_enable();
> +       else if (enable == 0)
> +               hdaps_mousedev_disable();
> +       spin_unlock(&hdaps_lock);
> +
> +       return count;
> +}

input_[un]register_device and del_timer_sync are "long" operations. I
think a semaphore would be better here.

-- 
Dmitry
