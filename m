Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293424AbSB1Qia>; Thu, 28 Feb 2002 11:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293199AbSB1QgM>; Thu, 28 Feb 2002 11:36:12 -0500
Received: from winds.org ([209.115.81.9]:62989 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S293460AbSB1QeE>;
	Thu, 28 Feb 2002 11:34:04 -0500
Date: Thu, 28 Feb 2002 11:33:05 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Artiom Morozov <artiom@phreaker.net>
cc: linux-kernel@vger.kernel.org, Kiretchko Serguei <spk@csp.org.by>
Subject: Re: select() call corrupts stack
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by>
Message-ID: <Pine.LNX.4.44.0202281128270.22844-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Artiom Morozov wrote:

> Hello,
> 
> 	Here's a sample program. Try running it and open about 2k of 
> connections to port 5222 (you'll need ulimit -n 10000 or like that). It 
> will segfault. Simple asm like this

> ps: it's okay for 1k of connections or so

printf("%d\n", sizeof(fd_set));

You'll see that it's 128, which is equivalent to 1024 bits, or 1024 possible
open connections that can be held in that variable. I would consider using a
dynamically-resizable memory space like in the code below to do what you want:

    struct timeval timeout;
    static fd_set *input_set, *output_set;
    static int fdset_size;

    extern int top_desc;

    /* dynamically grow file descriptor sets when needed (for >1024 FDs) */
    if(!input_set || (fdset_size-8)*8 <= top_desc) {
      free(input_set);
      free(output_set);
      fdset_size=(top_desc/64+2)*8;
      input_set=malloc(fdset_size);
      output_set=malloc(fdset_size);
    }

    /* clear input/output file descriptor sets */
    memset(input_set, 0, fdset_size);
    memset(output_set, 0, fdset_size);

    [... insert code to set input_set/output_set bits using FD_SET ...]

    select(top_desc+1, input_set, output_set, NULL, &timeout);


 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

