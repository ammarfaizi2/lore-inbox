Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbSIQVU4>; Tue, 17 Sep 2002 17:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSIQVUz>; Tue, 17 Sep 2002 17:20:55 -0400
Received: from zok.SGI.COM ([204.94.215.101]:51896 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S264616AbSIQVUx>;
	Tue, 17 Sep 2002 17:20:53 -0400
Date: Tue, 17 Sep 2002 14:25:44 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: libaio 0.3.92 test release
Message-ID: <20020917212544.GA1537314@sgi.com>
Mail-Followup-To: Benjamin LaHaise <bcrl@redhat.com>, linux-aio@kvack.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020916221219.A22465@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020916221219.A22465@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 10:12:19PM -0400, Benjamin LaHaise wrote:
> Hello folks,
> 
> I've just uploaded the libaio 0.3.92 test release to kernel.org.  Most 
> notably, this release passes a few basic tests on ia64, and should work 
> on x86-64 too (but isn't tested).

Thanks Ben.  I just pulled down the latest patch and library and tried
them out on my ia64 box.  Many of the tests in the testsuite passed,
but I encountered a hang during 'make check' after 6.t ran.  Here's
the output up to that point:

[root@ainek1 harness]# make check
rm -f testdir/rofile
echo "test" >testdir/rofile
chmod 400 testdir/rofile
rm -f testdir/rwfile
echo "test" >testdir/rwfile
chmod 600 testdir/rwfile
rm -f testdir/wofile
echo "test" >testdir/wofile
chmod 200 testdir/wofile
./runtests.sh cases/2.p cases/3.p cases/4.p cases/5.p cases/6.p cases/7.p cases/8.p cases/10.p cases/11.p cases/12.p cases/13.p
Test run starting at Tue Sep 17 13:31:24 PDT 2002
Starting cases/2.p
expect -14: io_setup(-1000, 0xffffffffc0010000) = -14 [Bad address]
expect -14: io_setup( 1000, 0xffffffffc0010000) = -14 [Bad address]
expect -14: io_setup(    0, 0xffffffffc0010000) = -14 [Bad address]
expect -22: io_setup(-1000, 0x60000fffffffb990) = -22 [Invalid argument]
expect -22: io_setup(   -1, 0x60000fffffffb990) = -22 [Invalid argument]
expect -22: io_setup(    0, 0x60000fffffffb990) = -22 [Invalid argument]
expect   0: io_setup(    1, 0x60000fffffffb990) =   0 [Success]
expect -22: io_setup(    1, 0x60000fffffffb990) = -22 [Invalid argument]
test cases/2.t completed PASSED.
Completed cases/2.p with 0.
Starting cases/3.p
expect -22: io_submit(0xffffffffffffffff,   1, 0x60000fffffffb960) = -22 [Invalid argument]
expect   0: io_submit(0x2000000000044000,   0, 0x60000fffffffb960) =   0 [Success]
expect -14: io_submit(0x2000000000044000,   1,      (nil)) = -14 [Bad address]
expect -14: io_submit(0x2000000000044000,   1, 0xffffffffffffffff) = -14 [Bad address]
expect -14: io_submit(0x2000000000044000,   2, 0x60000fffffffb970) = -14 [Bad address]
expect -14: io_submit(0x2000000000044000,   2, 0x60000fffffffb980) = -14 [Bad address]
expect -22: io_submit(0x2000000000044000,  -1, 0x60000fffffffb960) = -22 [Invalid argument]
test cases/3.t completed PASSED.
Completed cases/3.p with 0.
Starting cases/4.p
expect  -9: (w), res = sync_submit: io_submit res=-9 [Bad file descriptor]
 -9 [Bad file descriptor]
expect  -9: (r), res = sync_submit: io_submit res=-9 [Bad file descriptor]
 -9 [Bad file descriptor]
expect 512: (w), res = 512 [Success]
expect 512: (r), res = 512 [Success]
expect -22: (r), res = -22 [Invalid argument]
expect -22: (w), res = -22 [Invalid argument]
expect   0: (r), res =   0 [Success]
expect   4: (w), res =   4 [Success]
expect   4: (w), res =   4 [Success]
expect   8: (r), res =   8 [Success]
read after append: [12345678]
expect -14: (r), res = -14 [Bad address]
expect -14: (w), res = -14 [Bad address]
expect -14: (w), res = 512 [Success] -- FAILED
test cases/4.t completed FAILED.
Completed cases/4.p with 1 -- FAILED.
Starting cases/5.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   -14: (r), res =   -14 [Bad address]
expect   512: (r), res =   -14 [Bad address] -- FAILED
expect   -14: (w), res =   -14 [Bad address]
test cases/5.t completed FAILED.
Completed cases/5.p with 1 -- FAILED.
Starting cases/6.p
size = 953648
expect 805306368: (w), res = 805306368 [Success]
expect 805306368: (r), res = sync_submit: io_getevents res=0 [Success]
    0 [Success] -- FAILED
test cases/6.t completed FAILED.

Unfortunately, I don't have kdb compiled into this kernel so I can't
give you a backtrace right now, but maybe you've already run into this
problem?

Thanks,
Jesse
