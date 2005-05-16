Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVEPGne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVEPGne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 02:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVEPGnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 02:43:32 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2129 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261390AbVEPGn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 02:43:26 -0400
Message-ID: <42884106.1010607@tls.msk.ru>
Date: Mon, 16 May 2005 10:43:18 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: socket file permissions and ownership
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike some other *nix flavours, linux honors normal
AF_LOCAL socket file permissions and ownership -- eg,
you can't connect to a socket if file permissions indicate
you can't read/write the file.

But at the same time, linux ignores *changes* in said
permissions/ownership.  The code:

  int sock;
  struct sockaddr_un sun;

  sock = socket(PF_LOCAL, SOCK_STREAM, 0);
  unlink(sun.sun_path);
  bind(sock, (struct sockaddr *)&sun, sizeof(sun));

  fchmod(sock, 0660);
  fchown(sock, 10, 20);

-- in this fragment (initialisation omitted for brevity),
fchown() and fchmod() calls succeed but does exactly nothing,
ie, no permission and ownership change occurs.

"Plain" chmod()/chown() (when referring to the file by name,
not by filedescriptor) works.

I was thinking about actually using the linux feature (linux
checking socket permissions), but it isn't quite possible to
do in a safe way.  That is, I want to be able to create a socket
with given permissions and ownership from within a root-owned
process in a directory not writable by the owner of the socket
to be created.  I can work around fchmod() by altering umask()
prior to bind() call.  But for owner...  Possible scenarios:

  fchown(sock, s_owner, s_group) -- gets ignored by linux

  seteuid(s_owner) before bind() -- s_owner does not have
   permissions to create file(s) in the given directory

  chown(sun.sun_path, s_owner, s_group) -- unsafe from
   security point of view, if parent directory isn't owned
   by root.

I know no other way to set ownership.  And all the above 3
does not work.

So the obvious question: what should linux do, stop honoring
socket permissions and continue ignoring fch*() calls, or
continue using permissions AND implement fch*() calls?
Current situation is.. wrong.  IMHO.

/mjt
