Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292354AbSB0Tlx>; Wed, 27 Feb 2002 14:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292909AbSB0Tlh>; Wed, 27 Feb 2002 14:41:37 -0500
Received: from air-2.osdl.org ([65.201.151.6]:45581 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292914AbSB0TjT>;
	Wed, 27 Feb 2002 14:39:19 -0500
Date: Wed, 27 Feb 2002 11:33:18 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Laurent <laurent@augias.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: read_proc issue
In-Reply-To: <E16fmE1-0000Mu-00@lsinitam>
Message-ID: <Pine.LNX.4.33L2.0202271122040.1463-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Laurent wrote:

| I'm developping a module which uses an entry in /proc (read-only)
| Currently my (*read_proc) function just write a integer in my /proc entry
| and increments it. Here is the code:
|
| static int number_read_procmem(char *buf, char **start, off_t offset, int
| count, int *eof, void *data)
| {
|         int len = 0;
|
|         len = sprintf(buf, "%d\n", number_current++);
|         *eof = 1;
|         return len;
| }
|
| the function is registered in init_module with this:
| create_proc_read_entry("number", 0, NULL, number_read_procmem, NULL);
|
| Problem is:
| when I 'cat /proc/number' multiple times, instead of getting
| 0
| 1
| 2
| 3
| ...
|
| I get
| 0
| 2
| 4
| 6
| ...


I was thinking that some part(s) of the proc-fs code might call
fs/proc/generic.c::proc_file_read() multiple times (internally),
but no, it's just the application (or libc) doing it AFAICT.

app. calls read() [Key data: with offset=0], which calls sys_read(),
which calls proc_file_read(), which returns N bytes, and then
proc_file_read() and sys_read() and read() return to the app.

When the app. gets N bytes of actual data on its read(), it
doesn't know whether it was at EOF or not, so it tries another
read() [with offset=N], and sys_read() calls proc_file_read()
again, both of which return 0, so the app. knows that there
is no more data.

-- 
~Randy

