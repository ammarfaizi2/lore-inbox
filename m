Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbRABBTV>; Mon, 1 Jan 2001 20:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRABBTL>; Mon, 1 Jan 2001 20:19:11 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:6181 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129765AbRABBTE>; Mon, 1 Jan 2001 20:19:04 -0500
Date: Mon, 1 Jan 2001 19:50:31 -0500 (EST)
From: stewart@neuron.com
To: linux-kernel@vger.kernel.org
Subject: sync() broken for raw devices in 2.4.x??
Message-ID: <Pine.LNX.4.10.10101011925130.1859-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I have a sync()/fdatasync() intensive application that is designed to work
 on both raw files and raw partitions. Today I upgraded my kernel to the
 new pre-release and found that my benchmark program would no longer finish
 when handed a raw partition. I've written a small Java program (my app is
 in Java) which demonstrates the bug. Make foo.dat a raw scsi partition to
 re-produce. In my case it's "mknod foo.dat b 8 18". 

// -----------------------------------------------------
import java.io.*;
public class sync {
    public static void main(String args[]) throws Exception {
        long ops = Long.parseLong(args[0]);
        byte dat[] = new byte[Integer.parseInt(args[1])];
        RandomAccessFile rf = new RandomAccessFile("foo.dat", "rw");
        long time = System.currentTimeMillis();
        long t2 = time;
        for (int i=0; i<ops; i++) {
            rf.write(dat);
            rf.getFD().sync();
            if (i%100 == 0) {
                long tm = System.currentTimeMillis();
                System.out.println("i="+i+"   sync avg ms="+((tm-t2)/100));
                t2 = tm;
            }
        }
        time = System.currentTimeMillis()-time;
        System.out.println("time = "+time+"ms");
        System.out.println(((ops*1000)/time)+" ops/sec");
    }
}
// -----------------------------------------------------

 I've included 2.2.17 as a baseline for comparison w/ 2.4.0-prerelease.
 Watch the avg sync times. The tests were run with the command-line:

   java sync 10000 4096


 2.2.17 on an ext2 file looks like this:

i=0 sync avg ms=0
i=100 sync avg ms=11
i=200 sync avg ms=13
...
i=9700 sync avg ms=21
i=9800 sync avg ms=21
i=9900 sync avg ms=21
time = 153510ms
65 ops/sec


 2.4.0 on an ext2 file looks like this:

=0 sync avg ms=0
i=100 sync avg ms=13
i=200 sync avg ms=13
...
i=9700 sync avg ms=16
i=9800 sync avg ms=16
i=9900 sync avg ms=15
time = 140780ms
71 ops/sec


 OK, that's better. My benchmarks confirm that under ext2, 2.4.0 is
 generally superior, though I'm still getting some suspicious hangs.
 I'll report back on that if I can reproduce it with a sample program.


 2.2.17 with a raw partition:

i=0 sync avg ms=0
i=100 sync avg ms=0
i=200 sync avg ms=0
...
i=9700 sync avg ms=0
i=9800 sync avg ms=1
i=9900 sync avg ms=1
time = 22825ms
438 ops/sec


 2.4.0 with a raw partition:

i=0 sync avg ms=0
i=100 sync avg ms=0
i=200 sync avg ms=0
...
i=9700 sync avg ms=39
i=9800 sync avg ms=39
i=9900 sync avg ms=40
time = 202406ms
49 ops/sec


 OK, 2.4.0 gets progressively (visibly) slower as the test goes on. Even
 under 2.2.17 the test would cycle between 0-6ms over several thousand
 iterations. This could be sped up/slowed by changing the data volume.
 2.4.0, however, never recovers and sync() times will become infinitely
 large. This explains why my benchmarks never complete.

 The system in this case is a dual p2-450 512MB ram and SCSI disks. I have
 not tested this with IDE drives under 2.4.0 nor have I performed these
 tests under other 2.4.x test kernels.

 Stewart


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
