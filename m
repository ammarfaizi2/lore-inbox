Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283551AbRK3ICD>; Fri, 30 Nov 2001 03:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283552AbRK3IB4>; Fri, 30 Nov 2001 03:01:56 -0500
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:35739 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id <S283551AbRK3IBn>; Fri, 30 Nov 2001 03:01:43 -0500
Date: Fri, 30 Nov 2001 03:01:36 -0500 (EST)
From: Ahmed Masud <masud@marauder.googgun.com>
To: Xiaozhou Qiu <xzqiu@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to communicate between kernel and user space?
In-Reply-To: <F56sjUHQHh2wLCVYl4m0000010f@hotmail.com>
Message-ID: <Pine.LNX.4.33.0111300240080.24257-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Xiaozhou Qiu wrote:

> Hi,
>
> I am sorry if this is a newbie's question. I am developing a kernel module
> which needs to call some crypt functions implemented in user space. Since
> those functions utilize openssl library, I assume there is no easy way to
> port them into kernel.
>

No there isn't really an easy way to put the entire OpenSSL library in the
kernel, and perhaps you don't want to do it on the outset.

The easiest (first draft) way to probably do it - not withstanding
operational constraints - is to create a pseduo character/block device -
write a userspace daemon for encryption / decryption - store the private
key in the kernel through /proc interface or an ioctl over the device.

And pass SSL requests and data back and forth using reads and writes over
the character/block device that you created.

If I understand the motivation correctly, you want some other parts of the
kernel to be able to use SSL .... The daemon pseudo code would be:

	struct {
		request_t 	req;
		params_t	parms;
	} request;

	sslfd = open ( "/dev/block" ) ;
	while(!eof()) {
		read(sslfd, &request, sizeof(request));
		switch(params.request) {
		OPEN_SSL_FUNCTION_1:
			openSSL_func1(params.data);
			full_up_return(retdata);
			write(&retdata);
			break;

		OPEN_SSL_FUNCTION_2:
			...
			break;

		default:
			invalid_request();
			break
		}
	}


> I wonder whether there is an easy and elegant way to call the user space
> functions from the kernel and get the results, if /proc can not be used.  If

The daemon would block until a request came through over the device.


> anybody knows where I can find a crypt library in the kernel, that will be a
> great help too.

Now ... ofcourse, and i haven't had much experience with this so perhaps
someone else can shed further light, the said daemon could eventually be
spawned by the kernel as a kernel thread ? I am a bit uncertain as to
whether this problem fits the kernel-thread paradigm.  Not sure.

You would have to worry about what happens if the daemon is NOT present in
a production environment?

Have a look at devfsd ... It's a very interesting tool that communicates
with the kernel and really provides services to the kernel rather than the
other way around.

---

On a grander note.. and this is simply an idea that's just sprung up so
please shoot it down if it's whacked - or perhaps not whacked :-).

Wouldn't it be cool to have a unified kernel interface to allow full blown
userspace progies that provided extended services to the kernel ( like the
open ssl example above ) - launched by the kernel as needed and providing
data back and forth using a more organized mechanism than ioctls?

Just a thought,

Ahmed.

