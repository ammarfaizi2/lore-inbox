Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVHZT1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVHZT1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVHZT1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:27:41 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:21903 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030227AbVHZT1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:27:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hz1XOP2mpvBa5v6aiE8kM111vIRqA1j1cJWzApbWEVhVjm8cxnPBjxic+k3jkhlBOjR+1OYfZXtJDMWIUz4IQeKP1P5Vmxzldz1BGo/9f9uBWTWu0xiyAkN0gJWMCCUR0ZuDBcNyQMQsE+I1wfTT39xX5v/hxyz6ZDIJsYLJ7rg=
Message-ID: <d120d500050826122768cd3612@mail.gmail.com>
Date: Fri, 26 Aug 2005 14:27:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Love <rml@novell.com>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125069494.18155.27.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125069494.18155.27.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Robert Love <rml@novell.com> wrote:
> +/* device class stuff */
> +
> +static DECLARE_COMPLETION(hdaps_obj_is_free);
> +static void hdaps_release_dev(struct device *dev)
> +{
> +       complete(&hdaps_obj_is_free);
> +}
> +

What this completion is used for? I don't see any other references to it.

> +
> +static void hdaps_mousedev_poll(unsigned long unused)
> +{
> +       int movex, movey, x, y, ret;
> +
> +       ret = accelerometer_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
> +       if (unlikely(ret))
> +               return;
> +
> +       movex = rest_x - x;
> +       movey = rest_y - y;
> +       if (abs(movex) > hdaps_mousedev_threshold)
> +               input_report_rel(&hdaps_idev, REL_Y, movex);
> +       if (abs(movey) > hdaps_mousedev_threshold)
> +               input_report_rel(&hdaps_idev, REL_X, movey);
> +       input_sync(&hdaps_idev);
> +
> +       mod_timer(&hdaps_poll_timer, jiffies + msecs_to_jiffies(hdaps_poll_ms));
> +}
> +

I'd rather you used absolute coordinates and set up
hdaps_idev->absfuzz to do the filtering.

> +static ssize_t hdaps_mousedev_store(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf, size_t count)
> +{
> +       int enable;
> +
> +       if (sscanf(buf, "%d\n", &enable) != 1)
> +               return -EINVAL;
> +
> +       if (enable == 1)
> +               hdaps_mousedev_enable();
> +       else if (enable == 0)
> +               hdaps_mousedev_disable();
> +
> +       return count;
> +}
> +

This is racy - 2 threads can try to do this simultaneously.

> +
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_position);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_variance);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_temp);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_calibrate);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_threshold);
> +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_poll_ms);
> +

What about using sysfs_attribute_group?

-- 
Dmitry
