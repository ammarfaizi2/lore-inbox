Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVCBXwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVCBXwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCBXvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:51:04 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:31435 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261199AbVCBXpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:45:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Thu, 3 Mar 2005 00:47:43 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
References: <200502252237.04110.rjw@sisk.pl> <200503022250.12823.rjw@sisk.pl> <20050302220537.GD1616@elf.ucw.cz>
In-Reply-To: <20050302220537.GD1616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fClJCejKJoYzxt6"
Message-Id: <200503030047.43625.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_fClJCejKJoYzxt6
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 2 of March 2005 23:05, Pavel Machek wrote:
> Hi!
> 
[-- snip --] 
> > It seems that we write to the BIOS while moving the image, at least on my box,
> > which is quite not correct, IMO.
[-- snip --]
> > 
> > IMO this may lead to unexpected results, like the mysterious reboots during
> > resume.
> 
> Well, I always thought that ROM-BIOS is expected to
> be... well... read-only? Can you really write to your BIOS? [I know
> about Flash-BIOSen, but they are certainly not writable by "normal"
> write.] Plus we should overwrite it with same values...
> 
> Anyway, IMO bios should be marked as reserved (and we should not be
> touching reserved pages). Can you verify that your BIOS is properly
> marked reserved? [Ccing l-k, this might be interesting.]

It is, but that's even more interesting.  Namely, the BIOS-e820 memory map
looks as follows:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

and the pages in the first two reserved areas are properly marked as reserved.
Moreover, there is an apparent hole between a0000 and e0000 which also
is marked as reserved.  However, we treat all of these pages as saveable
(a page is treated as non-saveable if it is marked as reserved _and_ satisfies
specific condition which is met by only one page on my system).  Consequently,
during resume we try to overwrite all of these pages and we not only try to
write to (theoretically) read-only areas, but also we try to write to where there's
nothing. :-)

Still, there are almost 3500 reserved pages on my system and I'm not sure that
we don't need to save at least some of them.  Anyway, I'm attaching the full
list of pages that are marked as reserved and treated as saveable, so they get
overwritten during resume.  Please have a look (these are virtual x86-64
addresses, but the mapping is straightforward).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_fClJCejKJoYzxt6
Content-Type: application/x-gzip;
  name="reserved_pages.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="reserved_pages.log.gz"

H4sICGJMJkIAA3Jlc2VydmVkX3BhZ2VzLmxvZwCd3DuOnbu6XuHcrdgNcFDfjaTcjNMD1e0kDgwf
w3DzvefcgAH/gA2OoUDJWm9SmqOgovjw337+4+e//8+f73/8t7///vOPv//jHx//6/efv058/J9f
//kfv//177//x3/55386Hx//6d/+/4vAi8SLgxd/8OIvXfz5pYu/+Kv7F391/+Kv7t/Ci8aLwYuF
Fxsv8OfqL/5c/cWfq7+fePGFF9948YMXuI9P3Mcn7uMT9/GJ+/jEfXziPj5xH5+4j0/cxyfu4xP3
8Yn7+MR9fOI+PnEfn7iPL9zHF+7jC/fxhfv4wn184T6+cB9fuI8v3McX7uML9/GF+/jCfXzhPr5w
H1+4j2/cxzfu4xv38Y37+MZ9fOM+vnEf37iPb9zHN+7jG/fxjfv4xn184z6+cR/fuI8f3McP7uMH
9/GD+/jBffzgPn5wHz+4jx/cxw/u4wf38YP7+MF9/OA+fnAfP7iPX9zHL+7jF/fxi/v4xX384j5+
cR+/uI9f3Mcv7uMX9/GL+/jFffziPn5xH7+0j3/N2IL2Efh0MD5oH/FB+4gP2kd80D7ig/YR+Fw0
8Llo4HPR+KB9xAftIz5oH/FB+4gP3EfgPgL3EbiPwH0E7iNwH4H7CNxH4D4C9xG4j8B9BO4jcB+B
+wjcR+I+EveRuI/EfSTuI3EfiftI3EfiPhL3kbiPxH0k7iNxH4n7SNxH4T4K91G4j8J9FO6jcB+F
+yjcR+E+CvdRuI/CfRTuo3Afhfso3EfjPhr30biPxn007qNxH437aNxH4z4a99G4j8Z9NO6jcR+N
+2jcx+A+BvcxuI/BfQzuY3Afg/sY3MfgPgb3MbiPwX0M7mNwH4P7GNzHwn0s3MfCfSzcx8J9LNzH
wn0s3MfCfSzcx8J9LNzHwn0s3MfCfSzcx8Z9bNzHxn1s3MfGfWzcx8Z9bNzHxn1s3MfGfWzcx8Z9
bNzHxn1s3MfBfRzcx8F9HNzHwX0c3MfBfRzcx8F9HNzHwX0c3MfBfRzcx8F9HNzHH9zHH9zHH9zH
H9zHH9zHH9zHH9zHH9zHH9zHH9zHH9zHH9zHH9zHH9zHH9wH9h+B/Udg/xHYfwT2H4H9R2D/Edh/
BPYfgf1HYP8R2H8E9h+B/Udg/xHYfwT2H4H9R2D/Edh/BPYfgf1HYP8R2H8E9h+B/Udg/xHYfwT2
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
vT1PIG9nrrfnWeTtzPX2PJW8nbnenueTtzPX2/Ok8nbmenueWd7OXG/P08vbmevteY55O3O9PU80
b2eut+fZ5u3M9fY85bydud6e5523M9fb8+TzduZ6e56B3s5cb8/T0NuZ6+15Lno7c709T0hvZ663
51np7cz19jw1vZ253p7np7cz19vzJPV25np7nqnezlxvz9PV25nr7XnOejtzvT1PXG9nrrfn2zu3
M9fb8xWe25nr7fkez+3M9fZ8med25np7vtFzO3O9PV/ruZ253p7v9tzOXG/PF3xuZ66351s+tzPX
2/NVn9uZ6+35vs/tzPX2fOnnduZ6e775cztzvT1f/7mdud6O6+243o7r7fks0O3M9fZ8IOh25np7
PhV0O3O9PR8Nup253p7PB93OXG/Ph4RuZ66355NCl7Pnu0K3M9fb84Wh25nr7fnW0O3M9fZ8deh2
5np7vj90O3O9PV8iup253p5vEt3OXG/P14luZ6635ztFtzPX2/PFotuZ6+35dtHtzPX2fMXoduZ6
e75ndDtzvT1fNrqdud6ebxzdzlxvz9eObmeut+e7R7cz19vzBaTbmevt+RbS7cz19nwV6Xbmenu+
j3Q7c709X0q6nbnenm8m3c5cb8/Xk25nrrfnO0q3M9fb80Wl25nr7fm20u3M9fZ8Zel25np7vrd0
O3O9PV9eup253p5vMN3OXG/P15huZ66357tMtzPX2/OFptuZ6+35VtPtzPX2fLXpduZ6e77fdDtz
vT1fcrqdud6ebzrdzlxvz9edbmeut+c7T7cz19vzxafbmevt+fbT7cz19nwF6nbmenu+B3U7c709
X4a6nbnenm9E3c5cb8/Xom5nrrfnu1G3M9fb8wWp25nr7fmW1O3M9fZ8Vep25np7vi91O3O9PV+a
up253p5vTt3OXG/P16duZ6q3129qpnoL59/C+bdw/i2cfwvn38L5t3/9w6mYqd7C+bdw/i2cfwvn
38L5t3D+7V/BiZnrzfm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP7tHYCZud6c
fwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L
59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ff
wvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5
t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw
/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/ex8pm5no7rjfn38L5t3D+LZx/C+ffwvm3cP4t
nH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/
C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn
38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C
+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3
cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cfwvn38L5t3D+
LZx/C+ffwvm3cP4tnH8L59/C+bdw/i2cf4tf15vzb+H8Wzj/Fs6/vf8vM1O9pfNv6fxbOv+Wzr+l
82/p/Ft+qN7S+bd0/i2df0vn39L5t3T+LZ1/e7saM3O9Of+Wzr+l82/p/Fs6/5bOv6Xzb+n8Wzr/
ls6/pfNv6fxbOv+Wzr+9QZqZud6cf0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn
39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S
+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3
dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+
LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/ex1xm5no7
rjfn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L
59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff
0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5
t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0
/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4t
nX9L59/S+bd0/i2df0vn39L5t3T+LZ1/S+ff0vm3dP4tnX9L59/S+bd0/i2df8tf15vzb+n8Wzr/
ls6/va8rm5nqrZx/K+ffyvm3cv6tnH8r59/qQ/VWzr+V82/l/Fs5/1bOv5Xzb+X82/uev5m53px/
K+ffyvm3cv6tnH8r59/K+bdy/q2cfyvn38r5t3L+rZx/K+ff3kDGzFxvzr+V82/l/Fs5/1bOv5Xz
b+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l
/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxb
Of9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/
Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bO
v5Xzb+X8Wzn/Vs6/lfNv7x+7zcz1dlxvzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9W
zr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/
lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xz
b+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l
/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxb
Of9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/Vs6/lfNv5fxbOf9Wzr+V82/l/Fs5/1bOv5Xzb+X8Wzn/
Vs6/lfNv5fxbOf9Wv64359/K+bdy/q2cf3tfnzQz1Vs7/9bOv7Xzb+38Wzv/1s6/9YfqrZ1/a+ff
2vm3dv6tnX9r59/a+bf3vWMzc705/9bOv7Xzb+38Wzv/1s6/tfNv7fxbO//Wzr+182/t/Fs7/9bO
v70v7JuZ6835t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6t
nX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/
a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn
39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a
+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/u39Y4CZud6O6835t3b+rZ1/a+ff
2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5
t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2
/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6t
nX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/
a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn
39r5t3b+rZ1/a+ff2vm3dv6tnX9r59/a+bd2/q2df2vn3/rX9eb8Wzv/1s6/tfNv7+tcZqZ6G+ff
xvm3cf5tnH8b59/G+bf5UL2N82/j/Ns4/zbOv43zb+P82zj/9r4HaWauN+ffxvm3cf5tnH8b59/G
+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm39wViM3O9Of82zr+N82/j/Ns4/zbOv43zb+P82zj/Ns6/
jfNv4/zbOP82zr+N82/j/Ns4/zbOv43zb+P82zj/Ns6/jfNv4/zbOP82zr+N82/j/Ns4/zbOv43z
b+P82zj/Ns6/jfNv4/zbOP82zr+N82/j/Ns4/zbOv43zb+P82zj/Ns6/jfNv4/zbOP82zr+N82/j
/Ns4/zbOv43zb+P82zj/Ns6/jfNv4/zbOP82zr+N82/j/Ns4/zbOv43zb+P82zj/Ns6/jfNv4/zb
OP82zr+N82/j/Ns4/zbOv43zb+P82zj/Ns6/jfNv4/zbOP82zr+N82/j/Ns4/zbOv43zb+P82zj/
Ns6/vf9aYmaut+N6c/5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx
/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5t
nH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/
G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn
38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G
+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3cf5tnH8b59/G+bdx/m2cfxvn38b5t3H+bZx/G+ffxvm3
+XW9Of82zr+N82/j/Nv7eomZqd6W82/L+bfl/Nty/m05/7acf1sfqrfl/Nty/m05/7acf1vOvy3n
35bzb+97WWbmenP+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/vC41m5npz
/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t
59+W82/L+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/LefflvNvy/m35fzb
cv5tOf+2nH9bzr8t59+W82/L+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/
LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/L+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X8
23L+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/vb5Nm5no7rjfn35bzb8v5
t+X823L+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/L+bfl/Nty/m05/7ac
f1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/L
+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/LefflvNvy/m35fzbcv5tOf+2
nH9bzr8t59+W82/L+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/tpx/W86/LefflvNv
y/m35fzbcv5tOf+2nH9bzr8t59+W82/L+bfl/Nty/m05/7acf1vOvy3n35bzb8v5t+X823L+bTn/
tpx/W86/LefflvNvy/m35fzbcv5tOf+2nH9bzr8t59+W82/L+bfl/Nty/m05/7acf1vOv61f15vz
b8v5t+X823L+7f3P3WametvOv23n37bzb9v5t+3823b+bX+o3rbzb9v5t+3823b+bTv/tp1/286/
ve+JmJnrzfm37fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vOv70vWJmZ6835t+38
23b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vO
v23n37bzb9v5t+3823b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2nX/bzr9t59+282/b+bft
/Nt2/m07/7adf9vOv23n37bzb9v5t+3823b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2nX/b
zr9t59+282/b+bft/Nt2/m07/7adf9vOv23n37bzb9v5t+3823b+bTv/tp1/286/befftvNv2/m3
7fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vOv73/2MzM9XZcb86/befftvNv2/m3
7fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vOv23n37bzb9v5t+3823b+bTv/tp1/
286/befftvNv2/m37fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vOv23n37bzb9v5
t+3823b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2nX/bzr9t59+282/b+bft/Nt2/m07/7ad
f9vOv23n37bzb9v5t+3823b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2nX/bzr9t59+282/b
+bft/Nt2/m07/7adf9vOv23n37bzb9v5t+3823b+bTv/tp1/286/befftvNv2/m37fzbdv5tO/+2
nX/bzr9t59+282/b+bft/Nt2/m07/7adf9vOv23n37bzb9v5t+3823b+bTv/tp1/27+uN+fftvNv
2/m37fzb609NzVRvx/m34/zbcf7tOP92nH87zr+dD9Xbcf7tOP92nH87zr8d59+O82/H+bf372bm
enP+7Tj/dpx/O86/HeffjvNvx/m34/zbcf7tOP92nH87zr8d59+O828nXW/Ovx3n347zb8f5t+P8
23H+7Tj/dpx/O86/HeffjvNvx/m34/zbcf7tOP92nH87zr8d59+O82/H+bfj/Ntx/u04/3acfzvO
vx3n347zb8f5t+P823H+7Tj/dpx/O86/HeffjvNvx/m34/zbcf7tOP92nH87zr8d59+O82/H+bfj
/Ntx/u04/3acfzvOvx3n347zb8f5t+P823H+7Tj/dpx/O86/HeffjvNvx/m34/zbcf7tOP92nH87
zr8d59+O82/H+bfj/Ntx/u04/3acfzvOvx3n347zb8f5t+P823H+7Tj/dpx/O86/HeffjvNvx/m3
4/zbcf7tOP92nH87zr8d59+O82/H+bfj/Ntx/u04//ZmVGbmejuuN+ffjvNvx/m34/zbcf7tOP92
nH87zr8d59+O82/H+bfj/Ntx/u04/3acfzvOvx3n347zb8f5t+P823H+7Tj/dox/i98vg0/ifd9D
zcSH6zUTH67XTHy4XjPx4XrNxIfrNRMfrtdMfLheM/Hhes3Uh+vbXKZ4zcQ389dMfDN/zcQ389dM
fDN/zVxv4XozlyleM9ebuUzxmrnezGWK18z1Zi5TvGauN3OZ4jVzvZnLFK+Z681cpnjNXG/mMsU/
Z+l6M5cpXjPXm7lM8Zq53sxlitfM9WYuU7xmrjdzmeI1c72ZyxSvmevNXKZ4zVxv5jLFP2fmMsVr
5nozlyleM9ebuUzxmrnezGWK18z1Zi5TvGauN3OZ4jVzvZnLFK+Z681cpnjN/l+9/W/EyWNns9YC
AA==

--Boundary-00=_fClJCejKJoYzxt6--
