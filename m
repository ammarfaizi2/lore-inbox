Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUCVBfK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 20:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUCVBfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 20:35:10 -0500
Received: from gamemakers.de ([217.160.141.117]:30932 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S261611AbUCVBe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 20:34:59 -0500
Message-ID: <405E4322.5030606@gamemakers.de>
Date: Mon, 22 Mar 2004 02:36:34 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: File change notification (enhanced dnotify)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I am working on a mechanism to let programs watch for file system 
changes in large directory trees or on the whole system. Since my last 
post in january I have been trying various approaches.

The current dnotify mechanism is very limited since it is not working 
for whole directory trees and it does not report much useful 
information. For example to watch for changes in the /home tree you 
would have to open every single directory in the tree, which would 
probably not even work since it would require more than the maximum 
number of file handles. If you have a directory with many files in it, 
the only thing dnotify tells you is that something has changed in the 
directory, so you have to rescan the whole directory to find out which 
file has changed. Kind of defeats the purpose of change notification...

My current approach is compatible with the existing dnotify mechanism, 
but extends it to work recursively and makes it possible to find out 
what exactly has happened in the directory. It works on the dcache 
level, so unlike my first approach it does not require unique inode 
numbers to uniquely identify a file.

It works like this: When a program wants to watch for changes for a 
directory or file, it does an ioctl like in the original dnotify 
mechanism. But there are some additional flags for the ioctl:

DN_RECURSIVE means that all subdirectories of the watched directory will 
be watched. A limitation is that this does not work over mount 
boundaries, so if you want to watch for changes on the whole system you 
will have to watch each mount point.

DN_EXTENDED means that extended information for the type of change is 
gathered. The information you get depends on the kind of change that 
happened. For example for a read access you get information about the 
file that has changed and the offset and size of the changed region.

As in the original dnotify mechanism, whenever one of the watched files 
changes the userspace program gets a signal. The program can then do 
another ioctl to find out what exactly has happened. The information 
passed to the userspace program is in a very compact form, but the 
program can reconstruct the path of the file and other interesting 
information. See the userspace program for how this works.

Programs that could benefit very much from this mechanism would be the 
fam daemon, KDE/gnome, various security tools etc. I am using KDE, and 
it is using the original dnotify mechanism quite extensively. When I 
start KDE it calls the original dnotify ioctl for *256* different 
directories! With the new extension it would be enough to watch three or 
four directories recursively.

A few remarks about the code:

This is experimental code. There might be some nasty deadlocks or race 
conditions.

Just like the original dnotify mechanism, this does not work with hard 
links.

For development, I divided the mechanism into a stub that has to be 
compiled into the kernel and a module that contains the bulk of the 
mechanism. That way I can try new things without rebooting every five 
minutes. This separation will no longer be nessecary when the mechanism 
is stable.

If somebody is interested, I will explain how exactly it works. The most 
important code is in the module, especially postevent and consumeevent. 
postevent traverses the dentry tree upwards until it finds everybody who 
is interested in an event. consumeevent adds the event to the buffers of 
all interested parties.

The module can be compiled in a separate directory. It has a tiny make 
script called "make".

The userspace program can be compiled using
"g++ -o dnotify dnotify.cpp"

patch against 2.6.3 for the stub:
<http://www.lambda-computing.com/~rudi/lkml/dnotify-0.1.patch>

source for the module:
<http://www.lambda-computing.com/~rudi/lkml/dnotify-module-0.1.tgz>

userspace program (c++) for testing:
<http://www.lambda-computing.com/~rudi/lkml/dnotify-user-0.1.tgz>

I would like to have feedback on the general approach before I spend 
more time refining this.

best regards,

    Rüdiger Klaehn
