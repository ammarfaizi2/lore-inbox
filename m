Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbUJZMn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUJZMn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUJZMn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:43:58 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:5437 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262250AbUJZMny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VVK4b20qERswcOqW3PWHWtqw6ZOvfxnmARn8v2IP7XvY5XpIaEGHTVbWmfJvs/rbQE4Sopp2/aewaqb1ye1kg9vagQa5NiHfa3kbZy508x4sGsMQ+rpBoblgIPs107rfDHqt+b+cJTvn7D3JJw9UGaS1AP8ueGkDYxiR6A5+TJY=
Message-ID: <605a56ed04102605433b9f368@mail.gmail.com>
Date: Tue, 26 Oct 2004 14:43:54 +0200
From: Arne Henrichsen <ahenric@gmail.com>
Reply-To: Arne Henrichsen <ahenric@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Problems with close() system call
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0410261329410.26803@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <605a56ed04102504401e0f469f@mail.gmail.com>
	 <Pine.LNX.4.53.0410261329410.26803@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 13:30:35 +0200 (MEST), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> 
> Best is to put a printk("i'm in ioctl()") in the ioctl() function and a
> printk("i'm in close()") in the close() one, to be really sure whether the
> close() function of your module is called.
> 

Yes, that is exactly what I am doing. I basically implement the
flush() call (for close) as the release() call was never called on
close. So my release call does nothing. What I see is that the flush
function gets called, even though I have never called the close()
system call from my user app.

I also print out the module counter, and it doesn't make sense who
increments it:

open(0): f_count = 1
ioctl(0): f_count = 2
ioctl(0): f_count = 5
open(1)): f_count = 1
ioctl(1): f_count = 2
flush(0): f_count = 7
ioctl(1): f_count = 5
open(2): f_count = 1
ioctl(2): f_count = 2
flush(1): f_count = 7

My user app looks something like this:
int fd[8];

for(i = 0; i < nr_dev; i)
  {
    sprintf(dev, "/dev/mydev_%c", '0' + i);
    fd[i] = open(dev, O_RDWR | O_SYNC);
    if(fd[i] < 0)
    {
      printf("Error opening device: %s - %s\n", dev, strerror(errno));
      goto test_error;
    }

    status = ioctl(fd[i], CMD1);
    if(status != 0)
    {
      printf("%s - %s\n", dev, strerror(errno));
    }

    status = ioctl(fd[i], CMD2);
    if(status != 0)
    {
      printf("%s - %s\n", dev, strerror(errno));
    }
  } /* for(port_id = 0; port_id < nr_ports; port_id++) */
  
Arne
