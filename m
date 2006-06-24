Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWFXXsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWFXXsc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 19:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFXXsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 19:48:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19214 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751263AbWFXXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 19:48:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pgjVn74Sv1OlBPxa4RBUky6/WWaOSud7vO20rhNl051rVV6f22Tgo3qmcfhMu7aUpILn0xSqE4T1Ly6QnskGML8gnfQ4UjI8oDY/ttdep+O21UwFqSHVnJ2yysUyXhNlDZYLGOBfFZvHTUDvksUe8IjMrtavZNvwPbgLboNPX/s=
Message-ID: <2c0942db0606241648h260b03a4u97424a9b431a6e81@mail.gmail.com>
Date: Sat, 24 Jun 2006 16:48:29 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Paul Drynoff" <pauldrynoff@gmail.com>
Subject: Re: [PATCH]: block_read_full_page: micro optimization
Cc: akpm@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060624110133.18cdda30.pauldrynoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060624110133.18cdda30.pauldrynoff@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/06, Paul Drynoff <pauldrynoff@gmail.com> wrote:
> I wonder, may be with such change kernel become little faster?
> -                               memset(kaddr + i * blocksize, 0, blocksize);
> +                               memset(kaddr + (i << inode->i_blkbits), 0, blocksize);

It's likely slower with this change, as you now require the CPU to
load inode->i_blkbits which, chances are, isn't hanging around handily
in a register like blocksize obviously is. So, you've increased
register pressure and added more fetches from memory instead of just
doing a simple (and cheap) multiplication. Not good.

Check the generated code for both cases. Smaller is usually better.
Benchmarking would be best, however, code changes that cause cache
misses or register pressure can be hard to measure well.

Ray
