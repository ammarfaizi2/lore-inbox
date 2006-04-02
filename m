Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDBJlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDBJlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWDBJlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:41:07 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:27788
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S932217AbWDBJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:41:05 -0400
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: [RFC] packet/socket owner match (fireflier) using skfilter
Date: Sun, 2 Apr 2006 12:40:21 +0300
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604021240.21290.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fireflier aims at providing per application filtering. That is allowing to 
create rules like: allow apache to listen on port 80 (and only apache, nobody 
else).

A couple of days ago fireflier security module + iptables fireflier match 
module started to work [8].

Before continuing the work on it, I ask for your advice, and comments on what 
I've done so far.
I have marked with [!] the issues that are currently the most important.

0. Getting the patch/code
---------------------
All code/patches is for kernel 2.6.16.1, and iptables 1.3.5

I didn't include the patch inline, since it is quite long (1800+ lines , 
~100k). So I uploaded them here:
http://edwintorok.googlepages.com/fireflier_kernel.html

James Morris's patches [5] didn't apply cleanly to 2.6.16.1, so I had to 
modify them a bit, I have uploaded the actual patches applied
to the kernel, and iptables. (I might have made mistakes in "porting" the 
skfilter patches to 2.6.16, please point them out to me)

For the impatient, a direct link to the download:
http://edwintorok.googlepages.com/fireflier_modules.zip
http://edwintorok.googlepages.com/skfilter_patches.zip

1. Background
-----------------------
The initial approach [1] as pointed out by several ([2],[3])  people was 
fundamentally wrong.

AFAIK there is currently work being done to solve this using SELinux [4], but 
I'd like to have 'per application filtering' even without SELinux, so I
looked at James Morris and Patrick McHardy's skfilter patches [5].

So my idea was, that we use James Morris's patches, but instead of using the 
selinux security context, we use a security context based on the process's 
(its executable's) inode+mountpoint. For this we need some sort of 
auto-labeling. The LSM hooks provide just enough hooks in the right places to 
support this.
I have also written an iptables match target (and appropriate userspace 
libipt_...) based on ipt_owner.c, that matches based on the labels (SIDs) 
provided by fireflier LSM.

A detailed description of why, and how I've done this can be found on the 
wiki[6].

This code is currently working, see the tests I have done:[8]

2. Goals of fireflier LSM module
----------------------------------------
    * auto label each process with its executable's inode+mountpoint, i.e. a 
process's security context = SID based on {mountpoint+inode of its 
executable}
    * auto label each file a process has access to. If multiple processes have 
access to the same file, then create a group SID, containing all the SIDs of 
processes having access it. 
    * If multiple processes have access to the same file, but were launched 
from the same executable, then don't label with group SID (like 10 apache 
processes accessing the same socket: the socket will get the SID of apache)
    * it won't deny any operation, it just labels
    * it is not intended to be used when selinux=1 enabled at boot. If selinux 
is enabled then selinux should be used to provide the security context, and 
not fireflier 

3. Issues with fireflier LSM
-----------------------------------------

3.1 Duplicate code
---------------------
I needed a SID <-> context mapping, and I've seen that SELinux already has 
such a data structure in sidtab.c
There was no way to use that as is, since it had no exported symbols, and 
besides my context structure was different from an SELinux context,
so I copied sidtab.c to fireflier LSM. The problem is that a bug gets fixed in 
sidtab.c, ... it doesn't in fireflier LSM.
How can I use the functionality provided by sidtab.c in my LSM without 
duplicating the code?
I have thought of this solution, but I'm not sure if it is the best:
* create a patch between the selinux sidtab, and fireflier sidtab
* every time sidtab.c is changed in the kernel copy it to fireflier
* apply the patch

Also hooks.c is based on hooks.c from SELinux.

3.2 Capability module doesn't support stacking [!]
-----------------------------------------------
I have to boot with capability.disable=1 in order to be able to load 
fireflier. Otherwise it fails to register (it can't register neither as 
primary, neither as secondary LSM). Can stacking be added to the capability 
module? 

3.3 Fireflier LSM loaded as module [!]
-----------------------------------
Currently fireflier LSM is loaded as a module, and not compiled in the kernel. 
Are there any security issues that might arise from this?
(such as [9])

3.4 Performance
------------------
The SID->context lookup uses hashtable, ok.
But  context->SID lookup uses linear search (through the hash-table), can this 
be improved?
Using another hash-table, that based on the hash of a context maps to a SID 
would solve this, but it needs additional memory.

As far as autolabel.c is concerned I need to do the following: label only 
sockets, and not all inodes, for this I need to provide hook for 
socket_create, and label inodes only there?

3.5 Testing
------------
I will have to implement auto-test, that test the labels are properly applied. 
For this purpose I have created a debugging mode, where I create files
in debugfs (it currently only creates them, that is it leaks memory, I'll fix 
this later).
Is there a recommended way to do such tests? How is SELinux being tested?



4. Issues with fireflier iptables match
----------------------------------------
This is what it can currently handle:
iptables -t skfilter -A SOCKET -m fireflier_match --inode-owner 
81949 --dev-owner /dev/root -j ACCEPT

4.1 No group matching yet [!]
--------------------------
It currently matches against individual SIDs only, and can't match against 
groups. (in case a socket has a group SID, it won't be matched by the rule)
I have thought of several [7] solutions, but I am not sure which one is the 
Right Way to do it. 
IMHO solution II ([7]) would be the appropriate one:
* if a packet arrives on a socket having a group SID, and the rule tells to 
match on a SID contained in that group, then:
   * mark the packet, that it has been matched by the SID (of this rule)
   * if the packet has been marked that is has been matched by all SIDs in the 
group, then the packet is allowed to pass (i.e. matched by the rule)

The problems are:
* Can I do packet marking outside the mangle table? (in the skfilter table)?
* What would the performance penalty be to mark packets?
* How much memory would this need?
* How do I do the actual packet marking?

4.2 Duplicate code
-------------------------

I haven't included the fireflier match inside ipt_owner.c, because I wanted it 
to be installed as easy as possible, and this means, that
both the LSM module, and math module are compiled outside of the kernel tree 
currently.

What would I need to do in order to have this merged in the kernel tree? What 
conditions does the module (patch) have to meet?
Should I create a patch that can be applied with patch-o-matic-ng?

4.3 Performance benchmark
---------------------------
What is recommended way to profile an iptables match module? What tests do you 
suggest?

4.4. Testing
--------------------
I'd like to implement auto-tests for the iptables module too.
Besides testing saving/loading the rules, I'd like to test if it actually 
works. I am thinking of doing this:
* start up 3 processes:
  - program A that forks itself, and listens on a non-shared socket (lets say 
port 80, apache)
  - program B, and C share a socket with the 3rd one (lets say port 25, 
postfix)
  - program D that doesn't fork (and listens on port 22, sshd)
* create rules that match on different scenarios:
  - dst port 80, apache inode => this has to match
  - dst port 25, inode of B => this mustn't match
  - dst port 25, inode of C => this should match (if using solution II[7])
  - dst port 22, inode of B => mustn't match
  - dst port 22, inode of D => has to match
and so on
Is there a "standard" way to run such tests?

4.5 IPV6
---------
Currently the fireflier module is IPv4 only, is there anything I have to look 
out for when I "port" it to ipv6?
Should I do this now? I see that ip|ip6|arp_tables are being moved to 
x_tables, does it mean that ipv4 and ipv6 are going to be "unified"?
Do I have to do anything to support x_tables?

5. Use of the kernel API [!]
----------------------

Are the functions I used in the 2 modules part of a stable kernel API? Did I 
use functions/structures that a driver isn't supposed to use?
Are there any plans to remove a feature I used in my modules?

P.S.: there are hard coded path in some files, that is going to be fixed in a 
later version

I am waiting for your advice/suggestions/comments.

(note: although some of the pages on the wiki were last updated on April the 
1st, they are not an April's fool joke)

Thanks in advance,
Edwin

[1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/0701.html
[2] http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/0709.html
[3] http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/0725.html
[4] http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/0792.html
[5] http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/1310.html
[6] http://fireflier.isgeeky.com/wiki/Kernel_module
[7]http://fireflier.isgeeky.com/wiki/Kernel_module#Multiple_programs_accessing_a_socket
[8] http://fireflier.isgeeky.com/wiki/Ipt_fireflier_test
[9]http://www.derkeiler.com/Mailing-Lists/securityfocus/bugtraq/2004-12/0390.html
