Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbUKQWrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUKQWrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbUKQWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:45:30 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:50850 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262599AbUKQWmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:42:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ibt4ygvc1waR+knsIwblTngqzIKwf64bIhcXdscc7WN00KFmQrLoSaj6UX2eEtJQy3s6B02l7VsElnk8sksme5+M4dPHvrXlyIOE4eP+GGTI8KFIIGpvHzZSYpToT6z98W4buigvAMzW15dvMk2Agd89uhsl4cTRcnjNJ6+nm9E=
Message-ID: <81b0412b04111714426d82cab2@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:42:52 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Catalin Drula <catalin.drula@imag.fr>
Subject: Re: AF_UNIX sockets: strange behaviour
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 16:29:14 +0100 (CET), Catalin Drula
<catalin.drula@imag.fr> wrote:
> I have a small application that communicates over Bluetooth. I use
> connection-oriented UNIX domain sockets (AF_UNIX, SOCK_STREAM) to
> communicate between the applications's threads. When reading from
> one of these sockets, I get a strange behaviour: if I read all the
> bytes that are available (13, in this case) all at once, it's fine;
> however, if I try to read in two smaller batches (say, first time
> 6, and second time 7), the first read returns (with the 6 bytes), but
> the second read never returns.

2.6.9, works. Could you post your code?

#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>

int main(int argc, char **argv)
{
    char buf[13];
    int s[2];
    if ( socketpair(AF_UNIX, SOCK_STREAM, 0, s) < 0 )
    {
	perror("socketpair");
	return 1;
    }
    if ( fork() == 0 )
    {
	close(s[0]);
	write(s[1], "023456789012", 13);
	read(s[1], buf, 1); /* wait for parent */
    }
    else
    {
	close(s[1]);
	if ( read(s[0], buf, 6) != 6 )
	    perror("6");
	if ( read(s[0], buf, 7) != 7 )
	    perror("6");
	close(s[0]);
    }
    return 0;
}
