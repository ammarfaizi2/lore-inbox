Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280948AbRKVSGJ>; Thu, 22 Nov 2001 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKVSF7>; Thu, 22 Nov 2001 13:05:59 -0500
Received: from vega.ipal.net ([206.97.148.120]:45991 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280948AbRKVSFn>;
	Thu, 22 Nov 2001 13:05:43 -0500
Date: Thu, 22 Nov 2001 12:05:42 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EINTR vs ERESTARTSYS, ERESTARTSYS not defined
Message-ID: <20011122120542.A19963@vega.ipal.net>
In-Reply-To: <20011122083623.A18057@vega.ipal.net> <jeherm7s6b.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeherm7s6b.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 04:15:40PM +0100, Andreas Schwab wrote:

| Phil Howard <phil-linux-kernel@ipal.net> writes:
| 
| |> The accept() call does indeed return errno==ERESTARTSYS to user space
| |> when coming back from signal handling, even though other things like
| |> poll() return errno==EINTR.  This would not really be a problem except
| |> for this in include/linux/errno.h starting at line 6:
| |> 
| |> +=============================================================================
| |> | #ifdef __KERNEL__
| |> | 
| |> | /* Should never be seen by user programs */
| |> | #define ERESTARTSYS     512
| |> | #define ERESTARTNOINTR  513
| |> | #define ERESTARTNOHAND  514     /* restart if no handler.. */
| |> | #define ENOIOCTLCMD     515     /* No ioctl command */
| |> +=============================================================================
| |> 
| |> So which way is it _supposed_ to be (so someone can patch things up
| |> to make it consistent):
| |> 
| |> 1.  User space should never see ERESTARTSYS from any system call
| 
| Yes.  The kernel either transforms it to EINTR, or restarts the syscall
| when the signal handler returns.

This code periodically quits because sometimes there is an unknown errno.

            for (;;) {
                memset( arg_sock_addr, 0, * arg_sock_addrlen );
                new_fd = accept( arg_sockfd_list[fd_index], arg_sock_addr, arg_sock_addrlen );
                if ( new_fd >= 0 ) break;
                if ( errno == EINTR ) continue;
                if ( errno == ECONNABORTED ) continue;
                break;
            }
            if ( new_fd <= 2 ) {
                perror( "daemon_accept: accept" );
                if ( fd_count > 1 ) continue;
                _exit( 1 ); // not very graceful
            }

Then strace showed ERESTARTSYS happening, and when I changed the code to:

            for (;;) {
                memset( arg_sock_addr, 0, * arg_sock_addrlen );
                new_fd = accept( arg_sockfd_list[fd_index], arg_sock_addr, arg_sock_addrlen );
                if ( new_fd >= 0 ) break;
                if ( errno == EINTR ) continue;
                if ( errno == ERESTARTSYS ) continue;
                if ( errno == ECONNABORTED ) continue;
                break;
            }
            if ( new_fd <= 2 ) {
                perror( "daemon_accept: accept" );
                if ( fd_count > 1 ) continue;
                _exit( 1 ); // not very graceful
            }

it started working solidly.  I had to define __KERNEL__ to get it.  But I don't
want to leave that in there for portable code.

Could this be an unintended leak of ERESTARTSYS?  I take it that what the comments
say is what is intended, and that what I actually get isn't.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
