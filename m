Return-Path: <linux-kernel-owner+w=401wt.eu-S1760800AbWLHSbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760800AbWLHSbW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760817AbWLHSbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:31:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36093 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760800AbWLHSbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:31:21 -0500
Message-ID: <4579AFA5.90003@us.ibm.com>
Date: Fri, 08 Dec 2006 12:32:05 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Shirish S Pargaonkar <shirishp@us.ibm.com>, simo <simo@samba.org>,
       Jeremy Allison <jra@samba.org>, linux-cifs-client@lists.samba.org
Subject: Re: -mm merge plans for 2.6.20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm wrote:
>deprecate-smbfs-in-favour-of-cifs.patch
>deprecate-smbfs-in-favour-of-cifs-docs.patch
>
> Am still waiting to hear from sfrench on the appropriateness of this.


smbfs deprecation is ok but there are a few things to consider:
1) Secure mounts:  although more secure mounts are possible now to
Windows (not just Samba) with the most recent NTLMv2 patch in the cifs
tree, implementation of Kerberized mounts are stuck in debates about the
right upcall mechanisms (gssapi/spnego blobs can be almost 64K in size,
and userspace turned out to need to keep state across a sequence of two 
to three
upcalls before discarding its state which complicates things).   smbfs 
can handle
kerberos mounts in some cases so this is critical, even though in 
practice ntlmv2
is often good enough.

2) minor holes in backlevel server (OS/2 and Windows 9x/WindowsME) support
cifs is better in many cases than smbfs for this now, but cifs does
not handle utimes() remotely to them  yet  ie setting date/time the old 
style
DOS or OS/2 way (cifs can of course query the time fine).   This may not 
matter
for most cases and would be pretty easy to finish up

3) Documentation - minor cifs vs. smbfs differences in 
syntax/behavior.   I have
added some of this to the cifs documentation .odt file but have not 
posted the
pdf yet nor updated the shorter fs/cifs/README with some of this
helpful information (differences in syntax to help users migrating from 
smbfs).
I will post that to the cifs project site as PDF and .ODT this weekend.

4) Hot bugs ... For most users we should be ok here, but there is one major
unresolved bug that worries me: the cache_reap bug ("sleeping function
called from invalid context" in list_del+0x9/0x6c)
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=214622
Not sure whose bug that will turn out to be and ACPI settings seem to
affect it but it obviously affects some 2.6.19 users.

Running simple tests on smbfs, I run into so many problems now though, it
is probably time to mark it as deprecated as Fedora etc. apparently 
already have.
