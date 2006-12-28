Return-Path: <linux-kernel-owner+w=401wt.eu-S1754851AbWL1NSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbWL1NSm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbWL1NSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:18:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39144 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbWL1NSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:18:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ryLAHPX7TII9V5KtF7MH7vhA2ODRzKWiJfWU+x2wZxorqp+qIzLEtRqzcQl8u1dDqSxl8mV9RgZr+6TQiBUmnIdwbFy731Chb4k2KjJv3qwwm+shP5FOJe3szuhiVs7sbDdDimgdeT27QIrtV0hklqnr0ZqeWt2VnnKV3v+T+BE=
Message-ID: <2e4afe1e0612280518s6bccefc5k29211c20a2a38062@mail.gmail.com>
Date: Thu, 28 Dec 2006 18:48:39 +0530
From: "Karuna sagar k" <karunasagark@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Testing framework
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a testing framework for file systems focusing on
repair and recovery areas. Right now, I have been timing fsck and
trying to determine the effectiveness of fsck. The idea that I have is
below.

In abstract terms, I create a file system (ideal state), corrupt it,
run fsck on it and compare the recovered state with the ideal one. So
the whole process is divided into phases:

1. Prepare Phase - a new file system is created, populated and aged.
This state of the file system is consistent and is considered as ideal
state. This state is to be recorded for later comparisons (during the
comparison phase).

2. Corruption Phase - the file system on the disk is corrupted. We
should be able to reproduce such corruption on different test runs
(probably not very accurately). This way we would be able to compare
the file systems in a better way.

3. Repair Phase - fsck is run to repair and recover the disk to a
consistent state. The time taken by fsck is determined here.

4. Comparison Phase - the current state (recovered state) is compared
(a logical comparison) with the ideal state. The comparison tells what
fsck recovered, and how close are the two states.

Apart from this we would also require a component to record the state
of the file system. For this we construct a tree (which represents the
state of the file system) where each node stores some info on the
files and directories in the file system and the tree structure
records the parent children relationship among the files and
directories.

Currently I am focusing on the corruption and comparison phases:

Corruption Phase:
Focus - the corruption should be reproducible. This gives the control
over the comparison between test runs and file systems. I am assuming
here that different test runs would deal with same files.

I have come across two approaches here:

Approach 1 -
1. Among the files present on the disk, we randomly choose few files.
2. For each such file, we will then find the meta data block info
(inode block).
3. We seek to such blocks and corrupt them (the corruption is done by
randomly writing data to the block or some predetermined info)
4. Such files are noted to reproduce the similar corruption.

The above approach looks at the file system from a very abstract view.
But there may be file system specific data structures on the disk (eg.
group descriptors in case of ext2). These are not handled by this
approach directly.

Approach 2 - We pick up meta data blocks from the disk, and form a
logical disk structure containing just these meta data blocks. The
blocks on the logical disk map onto the physical disk. We pick up
randomly blocks from this and corrupt them.

Comparison Phase:
We determine the logical equivalence between the recovered and ideal
states of the disk i.e. say if a file was lost during corruption and
fsck recovered it and put it in the lost+found directory. We have to
recognize this as logical equivalent and not report that the file is
lost.

Right now I have a basic implementation of the above with random
corruption (using fsfuzzer logic).

Any suggestions?

Thanks,
Karuna
