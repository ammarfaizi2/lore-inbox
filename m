Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSGSO6U>; Fri, 19 Jul 2002 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSGSO6U>; Fri, 19 Jul 2002 10:58:20 -0400
Received: from zipcon.net ([209.221.136.5]:65414 "HELO zipcon.net")
	by vger.kernel.org with SMTP id <S316677AbSGSO6U> convert rfc822-to-8bit;
	Fri, 19 Jul 2002 10:58:20 -0400
From: William D Waddington <csbwaddington@att.net>
To: linux-kernel@vger.kernel.org
Subject: [never mind] kiobufs and highmem
Date: Fri, 19 Jul 2002 08:00:00 -0700
Message-ID: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com>
X-Mailer: Forte Agent 1.9/32.560
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello All,
>
>I have a 2.4.x char driver which works fine, except in boxes with lots of
>memory.
>
>user_buffer -> write() -> map_user_kiobuf() -> pci_map_sg() -> Pci DMA
>
>I'm using the .page/.offset version of the scatterlist, but in the HIGHMEM case,
>map_user_kiobuf() seems to return peculiar page addresses.
>
>What is the state of kiobufs/HIGHMEM in 2.4.x?  Do I need to implement
>a bounce buffer in the driver?  Some email correspondence indicates so,
>but I would be grateful for a definitive word from the kernel folks.
>

I finally googled up a couple of threads that shed some light ...
Seems that page_address() will return 0 when used on a high mem entry
in the kiobuf maplist.

Looks like three (?) options: go back to copying to a kernel DMA
buffer for all cases (swell for performance), split the code path into
map_user and copy_user branches (not that fond of spaghetti),
or - in the highmem case - copy to a local buffer and populate the
kiobuf with those pages and feed that to pci_map_sg().

The last is my preference, as it keeps the code cleaner, and since
my hardware is scatter-gather, I can either build the local buffer out
of discrete pages (at load time) or allocate a (possibly) non-
contiguous kernel buffer.  I would prefer to not use kmalloc if
possible, since I don't really need contiguous pages, and would
like to keep the chances of allocation success as high as possible.

I haven't yet figured out how to allocate a (possibly) non-contiguous
buffer, since vmalloc is frowned on, or how to populate the kiobuf
with its pages.

Any advice gratefully accepted,
Bill

---------------------------------------
William D Waddington
Bainbridge Island, WA, USA
csbwaddington@att.net
waddington@tahomatech.com
william.waddington@beezmo.com
---------------------------------------

