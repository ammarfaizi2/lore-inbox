Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSH0QEq>; Tue, 27 Aug 2002 12:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSH0QEq>; Tue, 27 Aug 2002 12:04:46 -0400
Received: from boden.synopsys.com ([204.176.20.19]:29162 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S316544AbSH0QEi>; Tue, 27 Aug 2002 12:04:38 -0400
Date: Tue, 27 Aug 2002 18:08:42 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Mark Atwood <mra@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can a process easily get a list of all it's open fd?
Message-ID: <20020827160842.GA16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Mark Atwood <mra@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl> <m38z2s1fkj.fsf@khem.blackfedora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38z2s1fkj.fsf@khem.blackfedora.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tricky. You can use /proc/<getpid>/fd, and close all
handles listed here, but this has some caveats:
it's _very_ slow if you have many open files.
it's not portable.
it's not safe if you have a thread/signal handler running.

i never heard of a right way to do this.

-alex

int close_all_fd()
{
    char fdpath[PATH_MAX];
    DIR * dp;
    struct dirent * de;
    int fd;

    sprintf(fdpath, "/proc/%d/fd", getpid());
    dp = opendir(fdpath);
    if ( !dp )
	return -errno;
    while ( (de = readdir(dp)) )
    {
	if ( !strcmp(de->d_name, ".") || !strcmp(de->d_name, "..") )
	    continue;
	fd = strtol(de->d_name, 0, 10);
	if ( fd == dirfd(dp) || fd == 0 || fd == 1 || fd == 2 )
	    continue;

	if ( close(fd) < 0 )
	    fprintf(stderr, "%s: %s\n", de->d_name, strerror(errno));
    }
    closedir(dp);
    return 0;
}


On Tue, Aug 27, 2002 at 08:34:04AM -0700, Mark Atwood wrote:
> 
> I need to close all the none std[in|out|err] open fd's.
> 
> I've been told to do it like so:
> 
>   {
>     int i;
>     for (i=3; i<OPEN_MAX; i++)
>       close(i);
>   }
> 
> This is very slow, plus I have discovered that I can have open fd's with
> values greater than OPEN_MAX.
> 
> I thought about getting the max fd from rlimit, but that doesn't work
> either.  Say I have a rlimit of 1024 open fd's, and I open numbers 3
> thru 1023, then I close 3 thru 1022, then I set the rlimit down to
> 16. rlimit then returns 16, but the largest open fd is still 1023.
> 
> So that doesn't work.
> 
> And I still have the problem that looping between 3 and whatever I pick
> as the top and calling close on each in turn is very slow.
> 
> So what's the "right way" to do it?
> 
> I would *love* for there to be an ioctl or some syscall that I could
> pass a pointer to an int and a pointer to an int array, and it would
> come back telling me how many open fd's I've got, and fill in the
> array with those fd's.
> 
> -- 
> Mark Atwood   | Well done is better than well said.
> mra@pobox.com | 
> http://www.pobox.com/~mra
> -
