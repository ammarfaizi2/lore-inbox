Return-Path: <linux-kernel-owner+w=401wt.eu-S1755223AbXAAPjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbXAAPjJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbXAAPjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:39:09 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:12094 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbXAAPjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:39:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tsFKgDpb/V04b5zGWgnwj87roULG1yMXvi7J4vbNybrHEJhY4/1uFBPgDjYWi9XB32ozYq9wRrx8my0jF5aVrYYqaaX8576MghSP1Yv6FEn2aRcoD76gij7gR3zeYqryOij7n6M5+KpTTq2GdZYy4v+wK8crNrjqz3OhZszQ8JA=
Message-ID: <9e4733910701010739l473bf825wc282550b8d554f24@mail.gmail.com>
Date: Mon, 1 Jan 2007 10:39:07 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Paul Mundt" <lethal@linux-sh.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Using _syscall3 to manipulate files in a driver
In-Reply-To: <20070101145943.GA11787@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
	 <20070101145943.GA11787@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/07, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Dec 31, 2006 at 12:13:52PM -0500, Jon Smirl wrote:
> > I have the source code for a vendor written driver that is targeted at
> > 2.6.9. It includes this and then proceeds to manipulate files from the
> > driver.
> >
> > asmlinkage _syscall3(int,write,int,fd,const char *,buf,off_t,count)
> > asmlinkage _syscall3(int,read,int,fd,char *,buf,off_t,count)
> > asmlinkage _syscall3(int,open,const char *,file,int,flag,int,mode)
> > asmlinkage _syscall1(int,close,int,fd)
> >
> > What is the simplest way to get open/close/read/write working under
> > 2.6.20-rc2? I know this is horrible and shouldn't be done, I just want
> > to get the driver working long enough to see if it is worth saving.
> > I'm on x86.
> >
> In-kernel syscalls were removed by f5738ceed46782aea7663d62cb6398eb05fc4ce0.
> You can stub them back in if you want a quick and lame fix for the
> driver, but you're better off rewriting it to behave sensibly rather than
> wasting your time on vendor hacks.

I was able to achieve a temporary work around by manipulating 'struct
file' directly. This fixed things enough so that I could load the
driver and check it out. zd1211 wireless is a case where we have the
vendor supplying and supporting a GPL driver based on 2.6.9 that is
300K and not very integrated into the networking code.  Then there is
the zd1211rw project, 85K, which is in the kernel source and is a
rework of the vendor code by non-vendor developers, It is integrated
with the Linux networking internals.

The problem is that the vendor driver can do some things that the
zd1211rw version can't. I'm trying to figure out why some things are
working the vendor driver that fail in zd1211rw.

@@ -8684,7 +8691,8 @@ #endif		



 void zd1205_load_card_setting(struct zd1205_private *macp, u8 bInit)

 {

-	int ifp;

+	struct file *filp = NULL;

 	int bcount = 0;

 	mm_segment_t fs;

 	unsigned int file_length;

@@ -8705,12 +8713,17 @@ void zd1205_load_card_setting(struct zd1
 	set_fs(KERNEL_DS);



 	// open the file with the firmware for uploading

-	if (ifp = open(config_filename, O_RDONLY, 0 ), ifp < 0){

+	filp = filp_open(config_filename, O_RDONLY, 0);

+	if (IS_ERR_VALUE(PTR_ERR(filp))){

 		// error opening the file

		ZD1211DEBUG(0, "File opening did not success\n");

 		set_fs(fs);

 		return;

 	}

+	get_file(filp);



 	/* Get information about the file. */

 	//fstat (ifp, &file_info);

@@ -8722,11 +8735,13 @@ void zd1205_load_card_setting(struct zd1
 	old_buffer = buffer;



 	/* Read the file into the buffer. */

-	bcount = read(ifp, buffer, file_length);

+	bcount = filp->f_op->read(filp, buffer, file_length, 0);

 	ZD1211DEBUG(1, "bcount=%d\n", bcount);



 	// close the file

-	close(ifp);

+	filp_close(filp, 0);



 	// switch back the segment setting

 	set_fs(fs);



-- 
Jon Smirl
jonsmirl@gmail.com
