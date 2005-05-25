Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVEYMiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVEYMiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVEYMiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:38:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:35053 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262326AbVEYMh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:37:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: van <van.wanless@eqware.net>
Subject: Re: File I/O from within a driver
Date: Wed, 25 May 2005 14:18:44 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <2005524221531.650853@Oz>
In-Reply-To: <2005524221531.650853@Oz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505251418.44680.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 25 Mai 2005 07:15, van wrote:
>  The structure of media files is complex and I'd rather the calling application
>  didn't need to have any knowledge of that structure.  But how can the driver
>  do the necessary read() operations?  
>  
> I could, for example, have the application pass an open file descriptor in to
> my driver via an ioctl() call; if I understand matters correctly, my driver
> could then call sys_read().  I've never done anything like that before, never
> expected to need to, and it doesn't feel right.   

_if_ you want to read the file, use fget() and vfs_read() on the file
descriptor you get passed. It is however considered rather bad style to
do file I/O from drivers. As Brian Gerst said, better use mmap in user
space and pass the pointer via ioctl() or write().

> Can anyone suggest the *proper* way to accomplish this?

Your assumption that the driver should parse the media file structure
is probably wrong. You should rather do as much as possible in a user
space library. Pass a file name to a library call and have that 
work with all the complex parts of the file format, then define an
ioctl interface for the driver on a relatively low level.

Or even better, don't use ioctl() at all but implement only read()/write()
in the driver. E.g. for MPEG acceleration, you might want to have an
interface where you write a series of macro blocks to the character
device and read back pixel data.

	Arnd <><
