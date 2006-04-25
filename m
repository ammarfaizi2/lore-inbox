Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDYRzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDYRzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDYRzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:55:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:44736 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWDYRzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:55:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TfDChq0HjiqhHlTl8cPX3mx20i/8n1wP783ClzfAbgV1qNYAzZexif5hoCw4CcVGTyF5Pa81PXqDKu338/5f3KkZUO3HgfRhBXvvUx5PA208z2QJuANqqQDqVcFGcN2bHG1YzD2VHY9JY0/wVYKO09fWdVHnxdU+qbZR7XYdR84=
Message-ID: <d120d5000604251054h69dcec1cudf98bcace711969b@mail.gmail.com>
Date: Tue, 25 Apr 2006 13:54:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, dave@mielke.cc
Subject: Re: How should an application ask for uinput module load?
In-Reply-To: <20060328194210.GD4660@bouh.residence.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060328194210.GD4660@bouh.residence.ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> Hi,
>
> Given a freshly booted linux box, hence uinput is not loaded (why would
> it be, it doesn't drive any real hardware) ; what is the right way(tm)
> for an application to have the uinput module loaded, so that it can open
> /dev/input/uinput for emulating keypresses?
>
> - With good-old static /dev, we could just open /dev/input/uinput
>  (installed by the distribution), and thanks to a
>  alias char-major-10-223 uinput
>  line somewhere in /etc/modprobe.d, uinput finally gets auto-loaded.
>
> - With devfs, it doesn't look like it works (/dev/misc/uinput is not
>  present and opening it just like if it existed doesn't work). But I
>  read in archives that it could be feasible.
>
> - With udev, this just cannot work. As explained in an earlier thread,
>  even using a special filesystem that would report the opening attempt
>  to udevd wouldn't work fine since udevd takes time for creating the
>  device, and hence the original program needs to be notified ; this
>  becomes racy.
>
> So what is the correct way to do it? I can see two approaches:
>
> Using modprobe:
> - try to use /dev/input/uinput ; if it succeeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>  - try to call `cat /proc/sys/kernel/modprobe` uinput
>  - try to use /dev/input/uinput again ; if it succeeds, fine
>    - else, assume that it really wasn't compiled, and hence fail.
>
> Triggering auto-load by creating one's own node.
> - try to use /dev/input/uinput ; if it suceeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>  - mknod /somewhere/safe/uinput c 10 223
>  - use /somewhere/safe/uinput ; if it succeeds, fine
>    - else, assume that it really wasn't compiled, and hence fail.
>
> I guess the same problem arises for loop devices and all such virtual
> devices...
>

Hi Samuel,

I am not sure about loop devices but for uinput there is most likely a
daemon that needs to be started so I would just load the module
(modprobe uinput) right from the same script that starts the daemon.
You do not need to check if module has already been loaded, just try
loading it unconditionally and use /dev/input/uinput.

--
Dmitry
